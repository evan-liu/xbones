package xbones.bones
{
    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.text.TextFormat;
    /**
     * The Label bone for displaying a single line of text.
     * @author eidiot
     */
    public class XLabel extends Sprite
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
            if (format)
            {
                textField.defaultTextFormat = format;
            }
            this.text = text;
            mouseEnabled = false;
            mouseChildren = false;
        }
        //======================================================================
        //  Variables
        //======================================================================
        protected var textField:TextField;
        //======================================================================
        //  Overridden properties: DisplayObject
        //======================================================================
        //------------------------------
        //  width
        //------------------------------
        protected var _width:Number = -1;
        /**
         * @protected
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
        protected var _height:Number = -1;
        /**
         * @protected
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
        //  text
        //------------------------------
        /**
         * @inheritDoc
         */
        public function get text():String
        {
            return textField.text;
        }
        /**
         * @protected
         */
        public function set text(value:String):void
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
        //  format
        //------------------------------
        /**
         * @inheritDoc
         */
        public function get format():TextFormat
        {
            return textField.defaultTextFormat;
        }
        /**
         * @protected
         */
        public function set format(value:TextFormat):void
        {
            if (!value || value == format)
            {
                return;
            }
            textField.defaultTextFormat = value;
            textField.setTextFormat(value);
            if (_autoSize)
            {
                textField.width = textField.textWidth + 4;
                textField.height = textField.textHeight + 4;
            }
        }
        //------------------------------
        //  autoSize
        //------------------------------
        protected var _autoSize:Boolean = true;
        /**
         * whether or not this Label will autosize.
         */
        public function get autoSize():Boolean
        {
            return _autoSize;
        }
        /**
         * @protected
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