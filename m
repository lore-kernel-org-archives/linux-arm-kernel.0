From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Jul 2013 12:36:01 +0100
Subject: [PATCH 3/3] ARM:dts:vf610-twr:Enable DSPI0 devices and Flash
 at26df081a
In-Reply-To: <1373272622-29064-3-git-send-email-b44548@freescale.com>
References: <1373272622-29064-1-git-send-email-b44548@freescale.com>
 <1373272622-29064-3-git-send-email-b44548@freescale.com>
Message-ID: <20130708113600.GU27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 04:37:02PM +0800, Chao Fu wrote:
> From: Chao Fu <B44548@freescale.com>
> 
> This patch enables DSPI0 and at26df081a flash device for Vybrid VF610 TOWER board.

Acked-by: Mark Brown <broonie@linaro.org>

This should be fine to merge via arm-soc, it's no real dependency on the
actual SPI driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130708/b9f66886/attachment.sig>
