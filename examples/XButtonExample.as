package
{
    import org.xbones.bones.XButton;

    import flash.events.MouseEvent;
    /**
     * @author eidiot
     */
    public class XButtonExample extends AbstractExample
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function XButtonExample()
        {
            super();
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var plusButton:XButton;
        private var minusButton:XButton;
        //======================================================================
        //  Overridden methods
        //======================================================================
        override protected function run():void
        {
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
        }
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