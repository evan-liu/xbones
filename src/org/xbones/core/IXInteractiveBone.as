package org.xbones.core
{
    /**
     * Interface for interactive bones.
     * @author eidiot
     */
    public interface IXInteractiveBone
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