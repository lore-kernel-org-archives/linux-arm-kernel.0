From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 25 Jul 2017 10:09:24 +0200
Subject: [PATCH v2 1/4] drm/atomic: implement
 drm_atomic_helper_commit_tail for runtime_pm users
In-Reply-To: <20170725065734.kbtb2mrfsjwm2szz@flea>
References: <cover.204b8c1b76558ee33ecf147e51c2b6a04d302d55.1500555652.git-series.maxime.ripard@free-electrons.com>
 <a8f92dc70048bab746e94dadd1c23200626aff60.1500555652.git-series.maxime.ripard@free-electrons.com>
 <20170720184628.5vizn7hjdaaz7rqy@phenom.ffwll.local>
 <20170725065734.kbtb2mrfsjwm2szz@flea>
Message-ID: <20170725080924.edh4h6njfxlwma7o@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 08:57:34AM +0200, Maxime Ripard wrote:
> Hi Daniel,
> 
> On Thu, Jul 20, 2017 at 08:46:28PM +0200, Daniel Vetter wrote:
> > On Thu, Jul 20, 2017 at 03:01:16PM +0200, Maxime Ripard wrote:
> > > The current drm_atomic_helper_commit_tail helper works only if the CRTC is
> > > accessible, and documents an alternative implementation that is supposed to
> > > be used if that happens.
> > > 
> > > That implementation is then duplicated by some drivers. Instead of
> > > documenting it, let's implement an helper that all the relevant users can
> > > use directly.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > Should I throw this into drm-misc, or do you want to merge this through
> > some driver tree?
> 
> Yes, you can put them in drm-misc, it will the be the easiest option.

Merged, thanks.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
