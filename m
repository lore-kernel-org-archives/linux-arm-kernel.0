From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 09:41:58 +0100
Subject: [PATCH v2 07/43] drm/sun4i: backend: Use a specific function to
 check if a plane is supported
In-Reply-To: <20181123092515.2511-8-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-8-paul.kocialkowski@bootlin.com>
Message-ID: <20181127084158.inmmvsf6ayhlhk7l@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:24:39AM +0100, Paul Kocialkowski wrote:
> Before this patch, it is assumed that a plane is supported either
> through the frontend or through the backend alone. However, the DRM
> interface does not allow finely reporting our hardware capabilities
> and there are cases where neither are support.
> 
> In particular, some plane formats are supported by the backend and not
> the frontend, so they can only be supported without scaling.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/7e51e211/attachment.sig>
