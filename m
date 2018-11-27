From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:49:28 +0100
Subject: [PATCH v2 09/43] drm/fourcc: Add format info helpers for
 checking YUV planes disposition
In-Reply-To: <20181123092515.2511-10-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-10-paul.kocialkowski@bootlin.com>
Message-ID: <20181127084928.qydnqypu3ppk3ksr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:41AM +0100, Paul Kocialkowski wrote:
> It is often useful to check whether the DRM format info retrieved from
> the DRM framebuffer matches a specific YUV planes disposition.
> 
> This introduces helpers to quickly check that a provided format info
> matches a YUV format with a specific disposition, in commonly-used
> terminology.
> 
> The intent of providing helpers taking the format info instead of the
> fourcc alone is to avoid the overhead of iterating through all formats
> when the whole format info structure is available. As a result, these
> helpers are very simple so they are made inline.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/3983b4ab/attachment.sig>
