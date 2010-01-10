package org.xbones.bones
{
    import org.xbones.core.IXCheckBox;
    import org.xbones.core.IXSelectableSkinner;
    import org.xbones.core.IXSkinner;
    import org.xbones.skins.XReflectionSelectableSkinner;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    import flash.text.TextFormat;
    /**
     * The CheckBox bone.
     * @author eidiot
     */
    public class XCheckBox extends Sprite implements IXCheckBox
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XCheckBox</code>.
         * @param label     Label text of the CheckBox bone.
         * @param skinner   Skinner of the CheckBox bone.
         */
        public function XCheckBox(label:String = "Label",
                                  selected:Boolean = false,
                                  skinner:IXSelectableSkinner = null)
        {
            super();
            _selected = selected;
            initializeSkinner(skinner);
            labelText = label;
            enabled = true;
            //
            buttonMode = true;
            mouseChildren = false;
            //
            addEventListener(MouseEvent.CLICK, clickHandler);
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var normalSkinner:IXSkinner;
        private var selectedSkinner:IXSkinner;
        private var currentSkinner:IXSkinner;
        private var currentSkin:DisplayObject;
        private var labelInstance:XLabel;
        //======================================================================
        //  Properties: IXCheckBox
        //======================================================================
        //------------------------------
        //  selected
        //------------------------------
        private var _selected:Boolean = false;
        /**
         * @inheritDoc
         */
        public function get selected():Boolean
        {
            return _selected;
        }
        /**
         * @private
         */
        public function set selected(value:Boolean):void
        {
            if (value == _selected)
            {
                return;
            }
            _selected = value;
            currentSkinner = _selected ? selectedSkinner : normalSkinner;
            updateSkin(checkMouseOver() ? currentSkinner.overSkin :
                                          currentSkinner.upSkin);
        }
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
            mouseEnabled = _enabled;
            if (_enabled)
            {
                updateSkin(checkMouseOver() ? currentSkinner.overSkin :
                                              currentSkinner.upSkin);
                addHandlers();
                renderLabelToEnabled();
            } else
            {
                updateSkin(currentSkinner.disabledSkin);
                removeHandlers();
                renderLabelToDisabled();
            }
        }
        //------------------------------
        //  labelText
        //------------------------------
        /**
         * @inheritDoc
         */
        public function get labelText():String
        {
            if (labelInstance)
            {
                return labelInstance.labelText;
            }
            return "";
        }
        /**
         * @private
         */
        public function set labelText(value:String):void
        {
            if (labelInstance)
            {
                labelInstance.labelText = value;
            }
            else
            {
                labelInstance = new XLabel(value);
                addChild(labelInstance);
                updateDisplay();
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
        //  Private methods
        //======================================================================
        private function initializeSkinner(value:IXSelectableSkinner):void
        {
            var skinner:IXSelectableSkinner = value;
            if (!skinner)
            {
                skinner = new XReflectionSelectableSkinner(BoneName.XCheckBox);
            }
            normalSkinner = skinner.normalSkinner;
            selectedSkinner = skinner.selectedSkinner;
            currentSkinner = _selected ? selectedSkinner : normalSkinner;
            updateSkin(currentSkinner.upSkin);
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
            if (!currentSkin)
            {
                currentSkin = currentSkinner.upSkin;
            }
            if (currentSkin)
            {
                addChild(currentSkin);
            }
        }
        private function updateDisplay():void
        {
            if (!currentSkin || !labelInstance)
            {
                return;
            }
            labelInstance.x = currentSkin.width + 5;
            labelInstance.y = (currentSkin.height - labelInstance.height + 4) / 2;
        }
        private function renderLabelToDisabled():void
        {
            if (labelInstance)
            {
                labelInstance.filters = [new GlowFilter(0x000000, 0)];
                labelInstance.alpha = 0.3;
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
        private function clickHandler(event:MouseEvent):void
        {
            if (_enabled) {
                selected = !selected;
            }
        }
        private function rollOverHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                updateSkin(currentSkinner.overSkin);
                addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            }
        }
        private function rollOutHandler(event:MouseEvent):void
        {
            removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            if (_enabled)
            {
                updateSkin(currentSkinner.upSkin);
            }
        }
        private function mouseUpHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
                updateSkin(checkMouseOver() ? currentSkinner.overSkin :
                                              currentSkinner.upSkin);
            }
        }
        private function mouseDownHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                updateSkin(currentSkinner.downSkin);
            }
            stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        }
    }
}