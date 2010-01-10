package org.xbones.skins
{
    import org.xbones.core.IXSkinner;

    import flash.display.DisplayObject;
    import flash.system.ApplicationDomain;
    /**
     * Control skin use reflection.
     * @author eidiot
     */
    public class XReflectionSkinner implements IXSkinner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>ReflectionControlSkin</code>.
         * @param boneName          Name of the bone like "Button".
         * @param applicationDomain <code>ApplicationDomain</code> to get
         *                          definitions of the skins.
         */
        public function XReflectionSkinner(boneName:String,
                                     applicationDomain:ApplicationDomain = null)
        {
            if (!applicationDomain)
            {
                applicationDomain = ApplicationDomain.currentDomain;
            }
            _upSkin = createSkin(applicationDomain, boneName + "_upSkin");
            _overSkin = createSkin(applicationDomain, boneName + "_overSkin");
            _downSkin = createSkin(applicationDomain, boneName + "_downSkin");
            _disabledSkin = createSkin(applicationDomain, boneName + "_disabledSkin");
            if (_upSkin)
            {
                if (!_overSkin)
                {
                    _overSkin = _upSkin;
                }
                if (!_downSkin)
                {
                    _downSkin = _upSkin;
                }
                if (!_disabledSkin)
                {
                    _disabledSkin = _upSkin;
                }
            }
        }
        //======================================================================
        //  Properties: IXBoneSkin
        //======================================================================
        //------------------------------
        //  upSkin
        //------------------------------
        private var _upSkin:DisplayObject;
        /**
         * @inheritDoc
         */
        public function get upSkin():DisplayObject
        {
            return _upSkin;
        }
        //------------------------------
        //  overSkin
        //------------------------------
        private var _overSkin:DisplayObject;
        /**
         * @inheritDoc
         */
        public function get overSkin():DisplayObject
        {
            return _overSkin;
        }
        //------------------------------
        //  downSkin
        //------------------------------
        private var _downSkin:DisplayObject;
        /**
         * @inheritDoc
         */
        public function get downSkin():DisplayObject
        {
            return _downSkin;
        }
        //------------------------------
        //  disabledSkin
        //------------------------------
        private var _disabledSkin:DisplayObject;
        /**
         * @inheritDoc
         */
        public function get disabledSkin():DisplayObject
        {
            return _disabledSkin;
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function createSkin(applicationDomain:ApplicationDomain,
                                skinName:String):DisplayObject
        {
            if (!applicationDomain.hasDefinition(skinName))
            {
                trace("[Warn] [XReflectionSkinner/createSkin] No " + skinName);
                return null;
            }
            var skinClass:Class =
                            applicationDomain.getDefinition(skinName) as Class;
            if (!skinClass)
            {
                trace("[Warn] [XReflectionSkinner/createSkin] No " + skinName);
                return null;
            }
            return new skinClass() as DisplayObject;
        }
    }
}
