From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:26:34 +0100
Subject: [PATCH v2 38/43] drm/sun4i: Move access control before setting
 the register as documented
In-Reply-To: <20181123092515.2511-39-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-39-paul.kocialkowski@bootlin.com>
Message-ID: <20181127092634.fq47rifbodtu7tk7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:25:10AM +0100, Paul Kocialkowski wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Unlike what is currently being done, the ACCESS_CTRL bit documentation asks
> that this bit should be set before modifying any register. The code in the
> BSP also does this, so make sure we do this as well.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

This patch (and the subsequent ones) are missing your SoB.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/f9319c43/attachment.sig>
