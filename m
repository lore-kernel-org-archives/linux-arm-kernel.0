From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 3 May 2018 13:02:16 +0200
Subject: [PATCH 09/13] drm/kms/mode/sun4i-tv: using helper func
 drm_display_mode_from_videomode for calculating timing parameters
In-Reply-To: <6919c8943505fe0c1f700e223a77194f85e64a58.1525087679.git.satendra.t@samsung.com>
References: <cover.1525087679.git.satendra.t@samsung.com>
 <CGME20180503105821epcas5p21a35d9eb29f83201d337a195d218fdd3@epcas5p2.samsung.com>
 <6919c8943505fe0c1f700e223a77194f85e64a58.1525087679.git.satendra.t@samsung.com>
Message-ID: <20180503110216.63bg3kw7cwppqbzx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 04:28:06PM +0530, Satendra Singh Thakur wrote:
> To avoid duplicate logic for horizonal/vertical sync_start/end
> helper func drm_display_mode_from_videomode is used
> 
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
> Cc: Madhur Verma <madhur.verma@samsung.com>
> Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180503/6253ace7/attachment.sig>
