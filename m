From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 22 Feb 2018 16:33:25 +0100
Subject: [PATCH v3 8/8] drm/sun4i: backend: Remove ARGB spoofing
In-Reply-To: <CAGb2v658h+MKv--py2cZdUp_iDje9MBSe8vOXBfgyoHRPyz_5g@mail.gmail.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <965180afd8169ccaa848f061d16a2c1a9ec4d289.1518802627.git-series.maxime.ripard@bootlin.com>
 <CAGb2v658h+MKv--py2cZdUp_iDje9MBSe8vOXBfgyoHRPyz_5g@mail.gmail.com>
Message-ID: <20180222153325.vbkpbscghlqcbnjc@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 10:15:07PM +0800, Chen-Yu Tsai wrote:
> On Sat, Feb 17, 2018 at 1:39 AM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > We've had some code for quite some time to prevent the alpha bug from
> > happening on the lowest primary plane. Since we now check for this in our
> > atomic_check, we can simply remove it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied the patches 4, 5, 6 and 8 with your reviewed-by.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180222/f31d1447/attachment.sig>
