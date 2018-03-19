From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Mar 2018 22:06:06 +0100
Subject: [PATCH 0/2] drm/sun4i: backend: Support interleaved YUV planes
In-Reply-To: <cover.f0cb3210f2d878853ef16506da152f38ba2e3286.1519931807.git-series.maxime.ripard@bootlin.com>
References: <cover.f0cb3210f2d878853ef16506da152f38ba2e3286.1519931807.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180319210606.svrm3a345736qhwf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 08:18:44PM +0100, Maxime Ripard wrote:
> Hi,
> 
> This is an attempt at supporting the interleaved YUV planes in the sun4i
> DRM driver for SoCs that use the DE1.
> 
> There's nothing out of the extraordinary there, we just have one more
> constraint in our DRM driver, since we can only have a single YUV plane.
> 
> Let me know what you think,
> Maxime

Applied both with Chen-Yu comments fixed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180319/c3893184/attachment.sig>
