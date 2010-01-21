package xbones.skins
{
    import xbones.core.IXWithSkinBone;
    import xbones.core.IXSkinner;

    import flash.display.MovieClip;
    /**
     * Skinner use frames of a MovieClip.
     * @author eidiot
     */
    public class XFrameSkinner implements IXSkinner
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XFrameSkinner</code>.
         */
        public function XFrameSkinner(movie:MovieClip, upFrame:int = 1,
                                      overFrame:int = 2, downFrame:int = 3,
                                      disabledFrame:int = 4)
        {
            this.movie = movie;
            const MAX:int = movie.totalFrames;
            this.upFrame = fixFrame(upFrame, 1, MAX, 1);
            this.overFrame = fixFrame(overFrame, 1, MAX, upFrame);
            this.downFrame = fixFrame(downFrame, 1, MAX, upFrame);
            this.disabledFrame = fixFrame(disabledFrame, 1, MAX, upFrame);
        }
        //======================================================================
        //  Variables
        //======================================================================
        protected var movie:MovieClip;
        protected var upFrame:int = 1;
        protected var overFrame:int = 1;
        protected var downFrame:int = 1;
        protected var disabledFrame:int = 1;
        //======================================================================
        //  Properties: IXSkinner
        //======================================================================
        protected var _bone:IXWithSkinBone;
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
        //  Public methods: IXSkinner
        //======================================================================
        /**
         * @inheritDoc
         */
        public function up():void
        {
            if (_bone && movie)
            {
                movie.gotoAndStop(upFrame);
                _bone.applySkin(movie);
            }
        }
        /**
         * @inheritDoc
         */
        public function over():void
        {
            if (_bone && movie)
            {
                movie.gotoAndStop(overFrame);
                _bone.applySkin(movie);
            }
        }
        /**
         * @inheritDoc
         */
        public function down():void
        {
            if (_bone && movie)
            {
                movie.gotoAndStop(downFrame);
                _bone.applySkin(movie);
            }
        }
        /**
         * @inheritDoc
         */
        public function disabled():void
        {
            if (_bone && movie)
            {
                movie.gotoAndStop(disabledFrame);
                _bone.applySkin(movie);
            }
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        protected function fixFrame(frame:int, min:int, max:int, fix:int):int
        {
            if (frame < min || frame > max)
            {
                return fix;
            }
            return frame;
        }
    }
}