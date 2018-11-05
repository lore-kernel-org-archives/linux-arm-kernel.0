From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 11:46:26 +0100
Subject: [PATCH 07/10] drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP,
 HSA_HSE
In-Reply-To: <20181103100900.30313-8-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
 <20181103100900.30313-8-jagan@amarulasolutions.com>
Message-ID: <20181105104626.ug4bwc3uc3vbyfpe@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2018 at 03:38:57PM +0530, Jagan Teki wrote:
> Horizontal back porch, sync active and sync end bits are
> needed to enable for burst mode panel operations.
> 
> So, enable them via dsi base control register.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

What is needed seems to be the exact opposite. The bits to *disable*
them.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/1cea515e/attachment.sig>
