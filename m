From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 4 Apr 2011 02:01:25 +0200
Subject: [PATCH 1/3] ARM: mx5/mx53_loco: Add write-protect and
	card-detect for SD3
In-Reply-To: <4D99028D.4000808@freescale.com>
References: <1301686188-14827-1-git-send-email-fabio.estevam@freescale.com>
	<4D99028D.4000808@freescale.com>
Message-ID: <20110404000125.GA19849@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> mmcblk1: error -84 transferring data, sector 32769, nr 32, card status 0x900    

Last time I had -EILSEQ, the buswidth-caps were wrong. Does the board support
8bit-width?

Hope it helps,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110404/aad41c86/attachment.sig>
