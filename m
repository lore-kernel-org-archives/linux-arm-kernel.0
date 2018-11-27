From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:52:07 +0100
Subject: [PATCH v2 14/43] drm/sun4i: backend: Avoid counting YUV planes
 that use the frontend
In-Reply-To: <20181123092515.2511-15-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-15-paul.kocialkowski@bootlin.com>
Message-ID: <20181127085207.5e3wgt7blfhzyrqd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:46AM +0100, Paul Kocialkowski wrote:
> Our hardware has a limited number of YUV planes (usually 1) that can be
> supported using the backend only. However, YUV planes can also be
> supported by the frontend and must then not be counted when checking for
> that limitation.
> 
> Only count the YUV plane when the frontend is not used.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/66e10e23/attachment.sig>
