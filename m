From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 18 Oct 2010 13:38:36 +0200
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <4CBC1528.40907@eukrea.com>
References: <20101013082930.GA11286@pengutronix.de>
	<8762x6xx00.fsf@lechat.rtp-net.org>
	<A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net>
	<20101013100632.GC11286@pengutronix.de>
	<4CB58565.5020806@eukrea.com>
	<A88EF4D64D8447468743DC1503C0B6CA0D557D@zch01exm22.fsl.freescale.net>
	<20101013102055.GD11286@pengutronix.de>
	<20101015102729.GB4276@pengutronix.de>
	<A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net>
	<4CBC1528.40907@eukrea.com>
Message-ID: <20101018113836.GB15440@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> you seems to be right, the attached patch seems to fix it (tested on our 
> board using a Linaro rootfs on a Transcend SDHC card and I didn't get 
> errors after applying this patch but I'm stopped by udev errors now with 
> this rootfs).

Is this needed on MX35, too?

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101018/1609f006/attachment.sig>
