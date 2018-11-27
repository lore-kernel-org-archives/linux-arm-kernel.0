From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:49:49 +0100
Subject: [PATCH v2 11/43] drm/fourcc: Add format info helpers for
 checking YUV sub-sampling
In-Reply-To: <20181123092515.2511-12-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-12-paul.kocialkowski@bootlin.com>
Message-ID: <20181127084949.2dk22mjgaq674qgq@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:43AM +0100, Paul Kocialkowski wrote:
> Display engine drivers often need to distinguish between different types of
> YUV sub-sampling. This introduces helpers to check for common sub-sampling
> ratios in their commonly-used denomination from the DRM format info.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/1f8bdf46/attachment-0001.sig>
