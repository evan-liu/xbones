package xbones.bones
{
    import xbones.core.IXWithSkinBone;
    import xbones.core.IXInteractiveBone;
    import xbones.core.IXWithLabelBone;
    import xbones.core.IXSkinner;
    import xbones.skins.XReflectionSkinner;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    import flash.text.TextFormat;
    /**
     * The Button bone (control).
     * @author eidiot
     */
    public class XButton extends Sprite implements IXWithSkinBone,
                                        IXInteractiveBone, IXWithLabelBone
    {
        //======================================================================
        //  Class constants
        //======================================================================
        private static const LABEL_MARGIN:int = 2;
        private static const LABEL_DISABLED_ALPHA:Number = 0.3;
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XButton</code>.
         * @param label     Label text of the button bone.
         * @param skinner   Skinner of the Button bone.
         */
        public function XButton(label:String = "", skinner:IXSkinner = null)
        {
            super();
            initializeSkinner(skinner);
            labelText = label;
            enabled = true;
            //
            buttonMode = true;
            mouseChildren = false;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var skinner:IXSkinner;
        private var currentSkin:DisplayObject;
        private var labelInstance:XLabel;
        //======================================================================
        //  Overridden properties: DisplayObject
        //======================================================================
        //------------------------------
        //  width
        //------------------------------
        private var _width:Number = -1;
        /**
         * @private
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
         * @private
         */
        override public function set height(value:Number):void
        {
            _height = value;
            if (currentSkin)
            {
                currentSkin.height = value;
            }
            updateDisplay();
        }
        //======================================================================
        //  Properties
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
                checkMouseOver() ? skinner.over() : skinner.up();
                addHandlers();
                renderLabelToEnabled();
            }
            else
            {
                skinner.disabled();
                removeHandlers();
                renderLabelToDisabled();
            }
        }
        //------------------------------
        //  labelText
        //------------------------------
        private var _labelText:String = "";
        /**
         * @inheritDoc
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
        //------------------------------
        //  labelFormat
        //------------------------------
        /**
         * @inheritDoc
         */
        public function get labelFormat():TextFormat
        {
            if (labelInstance)
            {
                return labelInstance.labelFormat;
            }
            return null;
        }
        /**
         * @private
         */
        public function set labelFormat(value:TextFormat):void
        {
            if (labelInstance)
            {
                labelInstance.labelFormat = value;
                updateDisplay();
            }
        }
        //======================================================================
        //  Public methods: IXWithSkinBone
        //======================================================================
        public function applySkin(skin:DisplayObject):void
        {
            updateSkin(skin);
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function initializeSkinner(value:IXSkinner):void
        {
            skinner = value;
            if (!skinner)
            {
                skinner = new XReflectionSkinner(XBoneName.XBUTTON);
            }
            skinner.bone = this;
            skinner.up();
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
            if (!currentSkin) {
                return;
            }
            addChildAt(currentSkin, 0);
            currentSkin.x = 0;
            currentSkin.y = 0;
            if (_width >= 0)
            {
                currentSkin.width = _width;
            }
            if (_height >= 0)
            {
                currentSkin.height = _height;
            }
        }
        private function updateLabel():void
        {
            if (labelInstance)
            {
                labelInstance.labelText = _labelText;
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
        private function updateDisplay():void
        {
            if (!currentSkin || !labelInstance)
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
            const MAX_LABEL_HEIGHT:Number = currentSkin.height;
            if (labelInstance.height > MAX_LABEL_HEIGHT)
            {
                labelInstance.y = 0;
                labelInstance.height = MAX_LABEL_HEIGHT;
            }
            else
            {
                labelInstance.y = (currentSkin.height - labelInstance.height) / 2;
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
        private function checkMouseOver():Boolean
        {
            return stage && hitTestPoint(stage.mouseX, stage.mouseY);
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
                skinner.over();
                addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            }
        }
        private function rollOutHandler(event:MouseEvent):void
        {
            removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            if (_enabled)
            {
                skinner.up();
            }
        }
        private function mouseUpHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
                checkMouseOver() ? skinner.over() : skinner.up();
            }
        }
        private function mouseDownHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                skinner.down();
            }
            stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        }
    }
}