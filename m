From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Nov 2018 09:30:36 +0100
Subject: [PATCH v2 03/12] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
 timings
In-Reply-To: <20181116163916.29621-4-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-4-jagan@amarulasolutions.com>
Message-ID: <20181119083036.riydru5xefao3xte@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 10:09:07PM +0530, Jagan Teki wrote:
> Burst mode display timings are different from convectional
> video mode so update the horizontal and vertical timings.
> 
> Reference code taken from BSP (from linux-sunxi/
> drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> 
> dsi_hsa  = 0;
> dsi_hbp  = 0;
> dsi_hact = x*dsi_pixel_bits[format]/8;
> dsi_hblk = dsi_hact;
> dsi_hfp  = 0;
> dsi_vblk = 0;
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

How is that matching the code you have in the rest of your patch?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181119/927a7a8e/attachment-0001.sig>
