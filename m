From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Jul 2017 08:44:12 +0200
Subject: [PATCH v2] drm/sun4i: Implement drm_driver lastclose to restore
 fbdev console
In-Reply-To: <CAGb2v67s=_Z_zcvpMmNZOmZ+y+J5EoxiAVfWpQ+UUxQipUe=sw@mail.gmail.com>
References: <20170709075951.16690-1-net147@gmail.com>
 <CAGb2v67s=_Z_zcvpMmNZOmZ+y+J5EoxiAVfWpQ+UUxQipUe=sw@mail.gmail.com>
Message-ID: <20170710064412.xpadh4p64krvohvi@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 09, 2017 at 11:11:07PM +0800, Chen-Yu Tsai wrote:
> On Sun, Jul 9, 2017 at 3:59 PM, Jonathan Liu <net147@gmail.com> wrote:
> > The drm_driver lastclose callback is called when the last userspace
> > DRM client has closed. Call drm_fbdev_cma_restore_mode to restore
> > the fbdev console otherwise the fbdev console will stop working.
> >
> > Signed-off-by: Jonathan Liu <net147@gmail.com>
> 
> This should have
> 
> Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
> 
> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

And it should be sent to stable too.

Can you resend it?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170710/f64b0505/attachment.sig>
