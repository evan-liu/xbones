package
{
    import org.xbones.bones.XButton;
    import org.xbones.skins.includeXSkin;

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.TextFormat;
    /**
     * @author eidiot
     */
    public class XButtonExample extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function XButtonExample()
        {
            super();
            includeXSkin(XButtonSkins);
            //-- Enabled example
            plusButton = new XButton("Plus");
            minusButton = new XButton("Minus");
            addChild(plusButton);
            addChild(minusButton);
            plusButton.x = 10;
            plusButton.y = 10;
            minusButton.x = plusButton.x + plusButton.width + 10;
            minusButton.y = 10;
            plusButton.addEventListener(MouseEvent.CLICK, button_clickHandler);
            minusButton.addEventListener(MouseEvent.CLICK, button_clickHandler);
            minusButton.enabled = false;
            //-- Label example
            var shortButton:XButton = new XButton("s");
            addChild(shortButton);
            shortButton.x = 10;
            shortButton.y = 50;
            shortButton.width = 20;
            var longButton:XButton = new XButton("This is a long button!");
            addChild(longButton);
            longButton.x = shortButton.x + shortButton.width + 10;
            longButton.y = shortButton.y;
            longButton.width = 140;
            //-- Format example
            var bigButton:XButton = new XButton("BIG");
            addChild(bigButton);
            bigButton.labelFormat = new TextFormat(null, 30);
            bigButton.x = 10;
            bigButton.y = 100;
            bigButton.height = 50;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var plusButton:XButton;
        private var minusButton:XButton;
        //======================================================================
        //  Event handlers
        //======================================================================
        private function button_clickHandler(event:MouseEvent):void
        {
            minusButton.enabled = !minusButton.enabled;
            plusButton.enabled = !plusButton.enabled;
        }
    }
}