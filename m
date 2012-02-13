From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 13 Feb 2012 15:41:26 +0100
Subject: [PATCH] mtd/gpmi : add gpmi support for mx6q
In-Reply-To: <1329134454.22240.114.camel@sauron.fi.intel.com>
References: <1328505606-27981-1-git-send-email-b32955@freescale.com>
 <1329134454.22240.114.camel@sauron.fi.intel.com>
Message-ID: <20120213144126.GB9537@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Please, let me know how I can compile-test this. This diver depends on
> imx23 or imx28 and I cannot find a defconfig for these. When I select
> MXS platform the compilation fails. Could you please describe some way
> to generate a compilable configuration which would include this driver
> as well, or send me the defconfig file.

I can't tell about MX6, but the defconfig for mx23/28 is called
mxs_defconfig.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120213/c1a93c32/attachment.sig>
