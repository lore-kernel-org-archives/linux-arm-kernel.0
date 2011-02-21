From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 21 Feb 2011 18:42:33 +0100
Subject: [PATCH v3 5/6] ARM: mxs/mx23evk: add mmc device
In-Reply-To: <1298284979-14853-6-git-send-email-shawn.guo@freescale.com>
References: <1298284979-14853-1-git-send-email-shawn.guo@freescale.com>
	<1298284979-14853-6-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110221174233.GP2616@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static struct mxs_mmc_platform_data mx23_mmc_pdata __initdata = {

Minor nit: Maybe mx23evk_mmc_pdata? (same for next patch)

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110221/dc4416a5/attachment.sig>
