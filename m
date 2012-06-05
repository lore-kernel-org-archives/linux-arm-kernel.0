From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 5 Jun 2012 11:10:48 +0100
Subject: [PATCH v2 REBASE] ASoC: fsl_ssi: convert to use devm_clk_get
In-Reply-To: <20120605064714.GL30400@pengutronix.de>
References: <1338774174-3960-1-git-send-email-richard.zhao@freescale.com>
 <20120605064714.GL30400@pengutronix.de>
Message-ID: <20120605101048.GI23408@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2012 at 08:47:14AM +0200, Sascha Hauer wrote:

> Have you tried compiling this on PowerPC? devm_clk_get is only available
> with CONFIG_CLKDEV_LOOKUP, I think on PowerPC this is not the case.

I just reverted the commit, we can try again when PowerPC has been
updated somehow.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120605/4198e562/attachment.sig>
