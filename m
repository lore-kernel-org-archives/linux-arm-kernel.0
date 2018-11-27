From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:38:43 +0100
Subject: [PATCH v2 04/43] drm/sun4i: backend: Add a helper and a list for
 supported formats
In-Reply-To: <20181123092515.2511-5-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-5-paul.kocialkowski@bootlin.com>
Message-ID: <20181127083843.l54uihmhcr3pnt3e@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:36AM +0100, Paul Kocialkowski wrote:
> In order to check whether the backend supports a specific format, an
> explicit list and a related helper are introduced.
> 
> The prototype of this helper is added to the header so that it can be
> called from sun4i_layer later (when introducing tiled mode support).
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/70f72d55/attachment.sig>
