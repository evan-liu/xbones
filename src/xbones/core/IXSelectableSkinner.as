package xbones.core
{
    /**
     * Interface of skinner for selectable bones.
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