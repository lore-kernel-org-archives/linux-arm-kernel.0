From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:55:29 +0100
Subject: [PATCH v2 19/43] drm/sun4i: frontend: Determine input mode based
 on the number of planes
In-Reply-To: <20181123092515.2511-20-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-20-paul.kocialkowski@bootlin.com>
Message-ID: <20181127085529.xj7vx4lcsfnidft7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:51AM +0100, Paul Kocialkowski wrote:
> Use the number of planes associated with the DRM format to determine the
> input mode configuration instead of the format iteself. This way, the
> helper can be used for all packed formats without future changes.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/dc2eb354/attachment.sig>
