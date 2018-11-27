From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:02:25 +0100
Subject: [PATCH v2 30/43] drm/fourcc: Add definitions for Allwinner
 vendor and VPU tiled format
In-Reply-To: <20181123092515.2511-31-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-31-paul.kocialkowski@bootlin.com>
Message-ID: <20181127090225.r7qsfbhgrgiwjwzs@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:25:02AM +0100, Paul Kocialkowski wrote:
> This introduces specific definitions for vendor Allwinner and its
> associated tiled format modifier. This modifier is used for the output
> format of the VPU, that can be imported directly with the display
> engine hardware supported by the sun4i-drm driver.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/4c36ba9c/attachment.sig>
