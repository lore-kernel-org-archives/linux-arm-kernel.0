From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 13 Jul 2018 09:01:55 +0200
Subject: [PATCH] drm/sun41: Fix incorrect return type
In-Reply-To: <20180712155037.211625-1-seanpaul@chromium.org>
References: <20180712155037.211625-1-seanpaul@chromium.org>
Message-ID: <20180713070155.3dodt43il4w6rjll@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

On Thu, Jul 12, 2018 at 11:50:28AM -0400, Sean Paul wrote:
> We're returning -errno instead of ERR_PTR(-errno).
> 
> Fixes: af11942ee44e ("drm/sun4i: tcon-top: Cleanup clock handling")
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: dri-devel at lists.freedesktop.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

I merged a similar patch yesterday, the warning should be gone now.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180713/f8cd09f4/attachment.sig>
