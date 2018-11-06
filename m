From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 6 Nov 2018 13:34:13 +0100
Subject: [PATCH] cedrus: check if kzalloc() fails
In-Reply-To: <b9bd5d87291191eeeef2b0611a1cc0acde52b2c9.1541503285.git.mchehab+samsung@kernel.org>
References: <b9bd5d87291191eeeef2b0611a1cc0acde52b2c9.1541503285.git.mchehab+samsung@kernel.org>
Message-ID: <20181106123413.fjd3rqm2f5vtgwpx@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 06:21:29AM -0500, Mauro Carvalho Chehab wrote:
> As warned by static code analizer checkers:
> 	drivers/staging/media/sunxi/cedrus/cedrus.c: drivers/staging/media/sunxi/cedrus/cedrus.c:93 cedrus_init_ctrls() error: potential null dereference 'ctx->ctrls'.  (kzalloc returns null)
> 
> The problem is that it assumes that kzalloc() will always
> succeed.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181106/92ae9614/attachment.sig>
