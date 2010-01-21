package xbones.bones
{
    import xbones.core.IXWithLabelBone;

    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    /**
     * The Label bone for displaying a single line of text.
     * @author eidiot
     */
    public class XLabel extends Sprite implements IXWithLabelBone
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XLabel</code>.
         * @param text Text value of the label.
         */
        public function XLabel(text:String = "", format:TextFormat = null)
        {
            super();
            textField = new TextField();
            addChild(textField);
            _labelFormat = format;
            if (!_labelFormat)
            {
                _labelFormat = new TextFormat();
            }
            this.labelText = text;
            mouseEnabled = false;
            mouseChildren = false;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var textField:TextField;
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
            if (value == _width)
            {
                return;
            }
            _width = value;
            textField.width = _width;
            if (_autoSize)
            {
                _autoSize = false;
                if (_height > 0)
                {
                    textField.height = _height;
                }
            }
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
            if (value == _height)
            {
                return;
            }
            _height = value;
            textField.height = _height;
            if (_autoSize)
            {
                _autoSize = false;
                if (_width > 0)
                {
                    textField.width = _width;
                }
            }
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  labelFormat
        //------------------------------
        private var _labelFormat:TextFormat;
        /**
         * @inheritDoc
         */
        public function get labelFormat():TextFormat
        {
            return _labelFormat;
        }
        /**
         * @private
         */
        public function set labelFormat(value:TextFormat):void
        {
            if (!value || value == _labelFormat)
            {
                return;
            }
            _labelFormat = value;
            textField.defaultTextFormat = _labelFormat;
            textField.setTextFormat(_labelFormat);
            if (_autoSize)
            {
                textField.width = textField.textWidth + 4;
                textField.height = textField.textHeight + 4;
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
            return textField.text;
        }
        /**
         * @private
         */
        public function set labelText(value:String):void
        {
            if (value == textField.text)
            {
                return;
            }
            textField.text = value;
            if (_autoSize)
            {
                textField.width = textField.textWidth + 4;
                textField.height = textField.textHeight + 4;
            }
        }
        //------------------------------
        //  autoSize
        //------------------------------
        private var _autoSize:Boolean = true;
        /**
         * whether or not this Label will autosize.
         */
        public function get autoSize():Boolean
        {
            return _autoSize;
        }
        /**
         * @private
         */
        public function set autoSize(value:Boolean):void
        {
            if (value == _autoSize)
            {
                return;
            }
            _autoSize = value;
            if (_autoSize)
            {
                textField.width = textField.textWidth + 4;
                textField.height = textField.textHeight + 4;
            }
        }
    }
}