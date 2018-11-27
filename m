From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:52:33 +0100
Subject: [PATCH v2 15/43] drm/sun4i: Rename sun4i_backend_layer_formats
 to sun4i_layer_formats
In-Reply-To: <20181123092515.2511-16-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-16-paul.kocialkowski@bootlin.com>
Message-ID: <20181127085233.4vvhv6vw3uksj7yg@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:47AM +0100, Paul Kocialkowski wrote:
> Since more formats can be supported by the frontend, rename the
> variable listing the layer formats to avoid suggesting that the backend
> itself supports all the listed formats.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/83d937d8/attachment.sig>
