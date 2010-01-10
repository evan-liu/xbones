package org.xbones.bones
{
    import org.xbones.core.IXBone;
    import org.xbones.core.IXSkinner;
    import org.xbones.skins.XReflectionSkin;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    /**
     * The Button bone (control).
     * @author eidiot
     */
    public class XButton extends Sprite implements IXBone
    {
        //======================================================================
        //  Class constants
        //======================================================================
        private static const LABEL_MARGIN:int = 2;
        private static const LABEL_DISABLED_ALPHA:Number = 0.3;
        //======================================================================
        //  Constructor
        //======================================================================
        public function XButton(label:String = "", skinner:IXSkinner = null)
        {
            super();
            initializeSkinner(skinner);
            this.labelText = label;
            buttonMode = true;
            mouseChildren = false;
            this.enabled = true;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var skinner:IXSkinner;
        private var currentSkin:DisplayObject;
        private var labelInstance:XLabel;
        private var isMouseDown:Boolean = false;
        //======================================================================
        //  Overridden properties: DisplayObject
        //======================================================================
        //------------------------------
        //  width
        //------------------------------
        private var _width:Number = -1;
        /**
         * @inheritDoc
         */
        override public function set width(value:Number):void
        {
            _width = value;
            if (currentSkin)
            {
                currentSkin.width = value;
            }
            updateDisplay();
        }
        //------------------------------
        //  height
        //------------------------------
        private var _height:Number = -1;
        /**
         * @inheritDoc
         */
        override public function set height(value:Number):void
        {
            _height = value;
            if (currentSkin)
            {
                currentSkin.height = value;
            }
        }
        //======================================================================
        //  Properties: IXBone
        //======================================================================
        //------------------------------
        //  enabled
        //------------------------------
        private var _enabled:Boolean = false;
        /**
         * @inheritDoc
         */
        public function get enabled():Boolean
        {
            return _enabled;
        }
        /**
         * @private
         */
        public function set enabled(value:Boolean):void
        {
            if (value == _enabled)
            {
                return;
            }
            _enabled = value;
            mouseEnabled = value;
            if (_enabled)
            {
                updateSkin(checkMouseOver() ? skinner.overSkin : skinner.upSkin);
                addHandlers();
                renderLabelToEnabled();
            }
            else
            {
                updateSkin(skinner.disabledSkin);
                removeHandlers();
                renderLabelToDisabled();
            }
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  labelText
        //------------------------------
        private var _labelText:String = "";
        /**
         * Label text of the button.
         */
        public function get labelText():String
        {
            return _labelText;
        }
        /**
         * @private
         */
        public function set labelText(value:String):void
        {
            if (value == _labelText)
            {
                return;
            }
            _labelText = value;
            if (value)
            {
                updateLabel();
            }
            else
            {
                removeLabel();
            }
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function initializeSkinner(value:IXSkinner):void
        {
            skinner = value;
            if (!skinner)
            {
                skinner = new XReflectionSkin(BoneName.BUTTON);
            }
            updateSkin(skinner.upSkin);
        }
        private function updateSkin(skin:DisplayObject):void
        {
            if (currentSkin)
            {
                if (currentSkin == skin)
                {
                    return;
                }
                if (currentSkin.parent)
                {
                    currentSkin.parent.removeChild(currentSkin);
                }
            }
            currentSkin = skin;
            addChildAt(skin, 0);
            if (_width >= 0)
            {
                skin.width = _width;
            }
            if (_height >= 0)
            {
                skin.height = _height;
            }
        }
        private function updateLabel():void
        {
            if (labelInstance)
            {
                labelInstance.text = _labelText;
            }
            else
            {
                labelInstance = new XLabel(_labelText);
            }
            if (labelInstance.parent != this)
            {
                addChild(labelInstance);
            }
            if (!_enabled)
            {
                renderLabelToDisabled();
            }
            updateDisplay();
        }
        private function removeLabel():void
        {
            if (labelInstance && labelInstance.parent)
            {
                labelInstance.parent.removeChild(labelInstance);
            }
        }
        private function renderLabelToDisabled():void
        {
            if (labelInstance)
            {
                labelInstance.filters = [new GlowFilter(0x000000, 0)];
                labelInstance.alpha = LABEL_DISABLED_ALPHA;
            }
        }
        private function renderLabelToEnabled():void
        {
            if (labelInstance)
            {
                labelInstance.filters = [];
                labelInstance.alpha = 1;
            }
        }
        private function updateDisplay():void
        {
            if (!labelInstance)
            {
                return;
            }
            labelInstance.y = (currentSkin.height - labelInstance.height) / 2;
            labelInstance.autoSize = true;
            const MAX_LABEL_WIDTH:Number = currentSkin.width - LABEL_MARGIN * 2;
            if (labelInstance.width > MAX_LABEL_WIDTH)
            {
                labelInstance.x = LABEL_MARGIN;
                labelInstance.width = MAX_LABEL_WIDTH;
            }
            else
            {
                labelInstance.x = (currentSkin.width - labelInstance.width) / 2;
            }
        }
        private function checkMouseOver():Boolean
        {
            if (stage)
            {
                return hitTestPoint(stage.mouseX, stage.mouseY);
            }
            return false;
        }
        private function addHandlers():void
        {
            addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        }
        private function removeHandlers():void
        {
            removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function rollOverHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                updateSkin(skinner.overSkin);
                addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            }
        }
        private function rollOutHandler(event:MouseEvent):void
        {
            removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            if (_enabled && !isMouseDown)
            {
                updateSkin(skinner.upSkin);
            }
        }
        private function mouseUpHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
                updateSkin(checkMouseOver() ? skinner.overSkin : skinner.upSkin);
            }
            isMouseDown = false;
        }
        private function mouseDownHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                updateSkin(skinner.downSkin);
            }
            stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
            isMouseDown = true;
        }
    }
}