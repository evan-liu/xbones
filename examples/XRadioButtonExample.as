package
{
    import xbones.bones.XRadioButton;
    import xbones.bones.XRadioButtonGroup;
    import xbones.skins.includeXSkin;

    import flash.display.Sprite;
    import flash.events.Event;
    /**
     * @author eidiot
     */
    public class XRadioButtonExample extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function XRadioButtonExample()
        {
            super();
            includeXSkin(XRadioButtonSkins);
            var radio1:XRadioButton = new XRadioButton("Enable", true, true);
            var radio2:XRadioButton = new XRadioButton("Disable", false, false);
            availableGroup = new XRadioButtonGroup();
            availableGroup.add(radio1, true);
            availableGroup.add(radio2);
            availableGroup.addEventListener(Event.CHANGE, availableGroup_changeHandler);
            //
            var radio3:XRadioButton = new XRadioButton("Flash");
            var radio4:XRadioButton = new XRadioButton("Flex");
            var radio5:XRadioButton = new XRadioButton("FDT", true);
            selectionGroup = new XRadioButtonGroup();
            selectionGroup.add(radio3);
            selectionGroup.add(radio4);
            selectionGroup.add(radio5, true);
            //
            addChild(radio1);
            addChild(radio2);
            addChild(radio3);
            addChild(radio4);
            addChild(radio5);
            //
            radio1.x = 10;
            radio2.x = 110;
            radio1.y = 10;
            radio2.y = 10;
            //
            radio3.x = 10;
            radio4.x = 110;
            radio5.x = 210;
            radio3.y = 50;
            radio4.y = 50;
            radio5.y = 50;
        }
        //======================================================================
        //  Variables
        //======================================================================
        private var selectionGroup:XRadioButtonGroup;
        private var availableGroup:XRadioButtonGroup;
        //======================================================================
        //  Event handlers
        //======================================================================
        private function availableGroup_changeHandler(event:Event):void
        {
            selectionGroup.enabled = Boolean(availableGroup.selectedValue);
        }
    }
}