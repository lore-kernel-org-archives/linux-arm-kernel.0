From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 10:13:51 +0100
Subject: [PATCH v2 32/43] drm/sun4i: Pass modifier to backend and
 frontend format support helpers
In-Reply-To: <20181123092515.2511-33-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-33-paul.kocialkowski@bootlin.com>
Message-ID: <20181127091351.ho4fmn2miph3xph7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 10:25:04AM +0100, Paul Kocialkowski wrote:
> To prepare the introduction of tiled mode support, pass the framebuffer
> format modifier to the helpers dealing with format support.
> 
> Since only linear mode is supported for now, add corresponding checks in
> each helper.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/591f8909/attachment.sig>
