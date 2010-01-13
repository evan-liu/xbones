package org.xbones.utils
{
    import org.xbones.bones.XButton;
    import org.xbones.core.IXSkinner;
    import org.xbones.skins.XFrameSkinner;

    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;


    /**
     * Convert a MovieClip to a button.
     * @param target       MovieClip to be converted.
     * @param label        Label of the button.
     * @param skinClass    Skinner class to skin the button.
     * @param args         Arguments to be passed to the skinner.
     */
    public function toXButton(target:MovieClip,
                              label:String = "",
                              skinClass:Class = null,
                              ...args):XButton
    {
        if (!target)
        {
            return null;
        }
        if (!skinClass)
        {
            skinClass = XFrameSkinner;
        }
        var parent:DisplayObjectContainer = target.parent;
        var index:int;
        var x:Number;
        var y:Number;
        if (parent)
        {
            index = parent.getChildIndex(target);
            x = target.x;
            y = target.y;
        }
        var skinner:IXSkinner;
        switch (args.length)
        {
            case 0:
                skinner = new skinClass(target);
                break;
            case 1:
                skinner = new skinClass(target, args[0]);
                break;
            case 2:
                skinner = new skinClass(target, args[0], args[1]);
                break;
            case 3:
                skinner = new skinClass(target, args[0], args[1], args[2]);
                break;
            case 4:
            default:
                skinner = new skinClass(target, args[0], args[1], args[2], args[3]);
                break;
        }
        if (!skinner)
        {
            return null;
        }
        var button:XButton = new XButton(label, skinner);
        if (parent)
        {
            parent.addChildAt(button, index);
            button.x = x;
            button.y = y;
        }
        return button;
    }
}