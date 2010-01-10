package org.xbones.core
{
    /**
     * Interface for CheckBox bone skinner.
     * @author eidiot
     */
    public interface IXSelectableSkinner
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  normalSkinner
        //------------------------------
        /**
         * Skinner for the normal state of the bone.
         */
        function get normalSkinner():IXSkinner;
        //------------------------------
        //  selectedSkinner
        //------------------------------
        /**
         * Skinner for the selected state of the bone.
         */
        function get selectedSkinner():IXSkinner;
    }
}