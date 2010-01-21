package xbones.skins
{
    import xbones.core.IXWithSkinBone;
    import xbones.core.IXSkinner;

    import flash.display.DisplayObject;
    import flash.system.ApplicationDomain;
    /**
     * Skinnerø use reflection.
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
        //  bone
        //------------------------------
        private var _bone:IXWithSkinBone;
        /**
         * @inheritDoc
         */
        public function get bone():IXWithSkinBone
        {
            return _bone;
        }
        /**
         * @private
         */
        public function set bone(value:IXWithSkinBone):void
        {
            _bone = value;
        }
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  upSkin
        //------------------------------
        private var _upSkin:DisplayObject;
        /**
         * Skin of the mouse up state
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
         * Skin of the mouse over state
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
         * Skin of the mouse down skin.
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
         * Skin of the disabled skin.
         */
        public function get disabledSkin():DisplayObject
        {
            return _disabledSkin;
        }
        //======================================================================
        //  Public methods
        //======================================================================
        /**
         * @inheritDoc
         */
        public function up():void
        {
            if (_bone && _upSkin)
            {
                _bone.applySkin(_upSkin);
            }
        }
        /**
         * @inheritDoc
         */
        public function over():void
        {
            if (_bone && _overSkin)
            {
                _bone.applySkin(_overSkin);
            }
        }
        /**
         * @inheritDoc
         */
        public function down():void
        {
            if (_bone && _downSkin)
            {
                _bone.applySkin(_downSkin);
            }
        }
        /**
         * @inheritDoc
         */
        public function disabled():void
        {
            if (_bone && _disabledSkin)
            {
                _bone.applySkin(_disabledSkin);
            }
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
