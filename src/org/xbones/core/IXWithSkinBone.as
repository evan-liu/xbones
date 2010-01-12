package org.xbones.core
{
    import flash.display.DisplayObject;
    /**
     * Interface for bones with skin.
     * @author eidiot
     */
    public interface IXWithSkinBone
    {
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * Apply skin for this bone.
         */
        function applySkin(skin:DisplayObject):void;
    }
}