package
{
    import org.xbones.bones.XCheckBox;
    import org.xbones.skins.includeXSkin;

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.TextFormat;
    /**
     * @author eidiot
     */
    public class XCheckBoxExample extends Sprite
    {
        //======================================================================
        //  Constructor
        //======================================================================
        public function XCheckBoxExample()
        {
            super();
            includeXSkin(XCheckBoxSkins);
            //--
            var box0:XCheckBox = new XCheckBox("Enable", true);
            var box1:XCheckBox = new XCheckBox("Flash");
            var box2:XCheckBox = new XCheckBox("Flex");
            var box3:XCheckBox = new XCheckBox("FDT", true);
            addChild(box0);
            addChild(box1);
            addChild(box2);
            addChild(box3);
            box0.x = 10;
            box1.x = 110;
            box2.x = 210;
            box3.x = 310;
            box0.y = 10;
            box1.y = 10;
            box2.y = 10;
            box3.y = 10;
            //--
            box3.labelFormat = new TextFormat(null, "30");
            //--
            box0.addEventListener(MouseEvent.CLICK, enableBox_clickHandler);
        }
        //======================================================================
        //  Event handlers
        //======================================================================
        private function enableBox_clickHandler(event:MouseEvent):void
        {
            var enabled:Boolean = XCheckBox(event.target).selected;
            for (var i:int = 1; i < numChildren; i++)
            {
                XCheckBox(getChildAt(i)).enabled = enabled;
            }
        }
    }
}