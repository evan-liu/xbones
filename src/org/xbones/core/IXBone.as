package org.xbones.core
{
    /**
     * Interface for all the bones (ui controls).
     * @author eidiot
     */
    public interface IXBone
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  enabled
        //------------------------------
        /**
         *  Whether the bone can accept user interaction.
         */
        function get enabled():Boolean;
        /**
         *  @private
         */
        function set enabled(value:Boolean):void;
    }
}