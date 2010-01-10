package org.xbones.core
{
    /**
     * Interface for selectable bones.
     * @author eidiot
     */
    public interface IXSelectableBone
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  selected
        //------------------------------
        /**
         * If the bone is selected.
         */
        function get selected():Boolean;
        /**
         * @private
         */
        function set selected(value:Boolean):void;
    }
}