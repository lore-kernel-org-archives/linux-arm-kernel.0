From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:53:52 +0100
Subject: [PATCH v2 17/43] drm/sun4i: frontend: Add helpers for input data
 mode and pixel sequence
In-Reply-To: <20181123092515.2511-18-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-18-paul.kocialkowski@bootlin.com>
Message-ID: <20181127085352.cxa3cyn657n3rz7z@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:49AM +0100, Paul Kocialkowski wrote:
> This introduces new helpers for retrieving the input data mode and pixel
> sequence register field values based on the DRM format instead of
> hardcoding these. This makes it easier to add support for more formats.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/64672fdd/attachment.sig>
