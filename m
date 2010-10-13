From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 13 Oct 2010 12:31:43 +0200
Subject: [PATCH v2 5/6] mmc: sdhci-of-esdhc: factor out common stuff
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0D557E@zch01exm22.fsl.freescale.net>
References: <1286806866-19258-6-git-send-email-w.sang@pengutronix.de>
	<1286817032-21219-1-git-send-email-w.sang@pengutronix.de>
	<20101011183300.GC21335@void.printf.net>
	<A88EF4D64D8447468743DC1503C0B6CA0D557E@zch01exm22.fsl.freescale.net>
Message-ID: <20101013103143.GE11286@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 06:22:14PM +0800, Zhu Richard-R65037 wrote:

> It's better that the mdelay(100) is replaced by some litter value such
> as 10ms and so on,
>  since I encounter one bug ever when this values is set to 100. The
> audio playback would
>  be noised by the sd/mmc insertion/extraction operations.

Okay. Can you send a patch (as you seem to have a testcase)?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101013/86a990e3/attachment.sig>
