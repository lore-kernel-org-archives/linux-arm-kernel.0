From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:39:24 +0100
Subject: [PATCH v2 06/43] drm/sun4i: backend: Refine the logic behind
 using the frontend
In-Reply-To: <20181123092515.2511-7-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-7-paul.kocialkowski@bootlin.com>
Message-ID: <20181127083924.qv7vapvaq3mjb4lu@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:38AM +0100, Paul Kocialkowski wrote:
> Checking that scaling is in use is not sufficient as a condition to
> decide to use the frontend.
> 
> Since not all layer formats are supported by the frontend, we need to
> check for that support first. Then, the frontend must only be enabled
> if the backend doesn't support the format or that scaling is required.
> 
> Signed-off-by:Paul Kocialkowski <paul.kocialkowski@bootlin.com>

You were missing a space to that SoB. I added it and applied, thanks!
maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/47bc0caa/attachment.sig>
