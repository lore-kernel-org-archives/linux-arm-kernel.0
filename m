From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:49:17 +0100
Subject: [PATCH v2 08/43] drm/fourcc: Add helper to check if a format
 uses a YUV colorspace
In-Reply-To: <20181123092515.2511-9-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-9-paul.kocialkowski@bootlin.com>
Message-ID: <20181127084917.omgbbm7tryw2r7un@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:40AM +0100, Paul Kocialkowski wrote:
> This adds a new helper to check whether the format described by its
> fourcc code uses a YUV colorspace, by returning the is_yuv entry for
> the DRM info entry matching that format.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/c112c030/attachment.sig>
