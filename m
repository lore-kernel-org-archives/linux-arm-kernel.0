From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 12 Mar 2018 10:44:13 +0100
Subject: [PATCH] drm/sun4i: Fix an error handling path in
 'sun4i_drv_bind()'
In-Reply-To: <20180311231909.5381-1-christophe.jaillet@wanadoo.fr>
References: <20180311231909.5381-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20180312094413.zck7apzghxs7brfr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 12:19:09AM +0100, Christophe JAILLET wrote:
> Commit 070badfab767 ("drm/sun4i: call drm_vblank_init with correct number
> of crtcs") has moved some code without updating the error handling gotos
> accordingly.
> 
> Branch to the correct label and remove a now unused lablel.
> 
> Fixes: 070badfab767 ("drm/sun4i: call drm_vblank_init with correct number of crtcs")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180312/05212c91/attachment.sig>
