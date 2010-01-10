package org.xbones.bones
{
    import flash.display.Sprite;
    import flash.text.TextField;
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
        public function XLabel(text:String = "")
        {
            super();
            textField = new TextField();
            addChild(textField);
            this.text = text;
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
        override public function set width(value:Number):void
        {
            if (value == _width)
            {
                return;
            }
            _width = value;
            _autoSize = false;
            textField.width = _width;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  text
        //------------------------------
        /**
         * Text of the label.
         */
        public function get text():String
        {
            return textField.text;
        }
        /**
         * @private
         */
        public function set text(value:String):void
        {
            if (value == textField.text)
            {
                return;
            }
            textField.text = value;
            textField.height = textField.textHeight + 4;
            if (_autoSize)
            {
                textField.width = textField.textWidth + 4;
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
            }
        }
    }
}