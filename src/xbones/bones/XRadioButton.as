package xbones.bones
{
    import xbones.core.IXSelectableSkinner;
    import xbones.core.IXWithSkinBone;
    import xbones.core.IXWithLabelBone;
    import xbones.core.IXSkinner;
    import xbones.core.IXSelectableBone;
    import xbones.core.IXInteractiveBone;
    import xbones.skins.XReflectionSelectableSkinner;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    import flash.text.TextFormat;

    //----------------------------------
    //  Events
    //----------------------------------
    /**
     * Dispatched when the selected state changes.
     * @eventType flash.events.Event.CHANGE
     */
    [Event(name="change", type="flash.events.Event")]

    /**
     * The RadioButton bone.
     * @author eidiot
     */
    public class XRadioButton extends Sprite implements IXWithSkinBone,
                            IXInteractiveBone, IXWithLabelBone, IXSelectableBone
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XRadioButton</code>.
         * @param label     Label text of the RadioButton bone.
         * @param skinner   Skinner of the RadioButton bone.
         */
        public function XRadioButton(label:String = "Label",
                                     selected:Boolean = false,
                                     data:Object = null,
                                     skinner:IXSelectableSkinner = null)
        {
            super();
            _data = data;
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
        //  Properties
        //======================================================================
        //------------------------------
        //  data
        //------------------------------
        private var _data:Object;
        /**
         * @inheritDoc
         */
        public function get data():Object
        {
            if (_data == null)
            {
                return labelText;
            }
            return _data;
        }
        /**
         * @private
         */
        public function set data(value:Object):void
        {
            _data = value;
        }
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
            checkMouseOver() ? currentSkinner.over() : currentSkinner.up();
            dispatchEvent(new Event(Event.CHANGE));
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
                checkMouseOver() ? currentSkinner.over() : currentSkinner.up();
                addHandlers();
                renderLabelToEnabled();
            }
            else
            {
                currentSkinner.disabled();
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
                return labelInstance.text;
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
                labelInstance.text = value;
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
                return labelInstance.format;
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
                labelInstance.format = value;
                updateDisplay();
            }
        }
        //======================================================================
        //  Public methods: IXWithSkinBone
        //======================================================================
        /**
         * @inheritDoc
         */
        public function applySkin(skin:DisplayObject):void
        {
            updateSkin(skin);
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function initializeSkinner(value:IXSelectableSkinner):void
        {
            var skinner:IXSelectableSkinner = value;
            if (!skinner)
            {
                skinner = new XReflectionSelectableSkinner(XBoneName.XRadioButton);
            }
            normalSkinner = skinner.normalSkinner;
            normalSkinner.bone = this;
            selectedSkinner = skinner.selectedSkinner;
            selectedSkinner.bone = this;
            currentSkinner = _selected ? selectedSkinner : normalSkinner;
            currentSkinner.up();
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
            if (_enabled && !_selected)
            {
                selected = true;
            }
        }
        private function rollOverHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                currentSkinner.over();
                addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            }
        }
        private function rollOutHandler(event:MouseEvent):void
        {
            removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
            if (_enabled)
            {
                currentSkinner.up();
            }
        }
        private function mouseUpHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
                checkMouseOver() ? currentSkinner.over() : currentSkinner.up();
            }
        }
        private function mouseDownHandler(event:MouseEvent):void
        {
            if (_enabled)
            {
                currentSkinner.down();
            }
            stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
        }
    }
}
