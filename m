From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 31 Mar 2010 10:10:04 +0200
Subject: [PATCH] netdev/fec.c: add phylib supporting to enable carrier
	detection
In-Reply-To: <20100331075746.GO2241@pengutronix.de>
References: <1269597052-10104-1-git-send-email-bryan.wu@canonical.com>
	<20100331075746.GO2241@pengutronix.de>
Message-ID: <20100331081004.GB23391@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> With rounding this would be:
> 
> (clk_get_rate() + 4999999) / 5000000

Better use DIV_ROUND_UP(clk_get_rate(), 5000000)?

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100331/7a00f71e/attachment.sig>
