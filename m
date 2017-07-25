From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Jul 2017 08:57:34 +0200
Subject: [PATCH v2 1/4] drm/atomic: implement
 drm_atomic_helper_commit_tail for runtime_pm users
In-Reply-To: <20170720184628.5vizn7hjdaaz7rqy@phenom.ffwll.local>
References: <cover.204b8c1b76558ee33ecf147e51c2b6a04d302d55.1500555652.git-series.maxime.ripard@free-electrons.com>
 <a8f92dc70048bab746e94dadd1c23200626aff60.1500555652.git-series.maxime.ripard@free-electrons.com>
 <20170720184628.5vizn7hjdaaz7rqy@phenom.ffwll.local>
Message-ID: <20170725065734.kbtb2mrfsjwm2szz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Thu, Jul 20, 2017 at 08:46:28PM +0200, Daniel Vetter wrote:
> On Thu, Jul 20, 2017 at 03:01:16PM +0200, Maxime Ripard wrote:
> > The current drm_atomic_helper_commit_tail helper works only if the CRTC is
> > accessible, and documents an alternative implementation that is supposed to
> > be used if that happens.
> > 
> > That implementation is then duplicated by some drivers. Instead of
> > documenting it, let's implement an helper that all the relevant users can
> > use directly.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Should I throw this into drm-misc, or do you want to merge this through
> some driver tree?

Yes, you can put them in drm-misc, it will the be the easiest option.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/7ada811f/attachment.sig>
