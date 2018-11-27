From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:57:36 +0100
Subject: [PATCH v2 23/43] drm/sun4i: backend: Detail the YUV to RGB
 values coding explanation
In-Reply-To: <20181123092515.2511-24-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-24-paul.kocialkowski@bootlin.com>
Message-ID: <20181127085736.mz3jn4o5nofp4rtu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:55AM +0100, Paul Kocialkowski wrote:
> From: Paul Kocialkowski <contact@paulk.fr>
> 
> The values in the BT601 YUV to RGB colorspace translation are not
> simply coded as multiples, but rather as fixed-point signed fractional
> values on a given number of bits. Add an explanation about that.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/8fd03197/attachment.sig>
