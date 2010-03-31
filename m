From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 31 Mar 2010 10:15:02 +0200
Subject: [PATCH] netdev/fec.c: add phylib supporting to enable carrier
	detection
In-Reply-To: <20100331081004.GB23391@pengutronix.de>
References: <1269597052-10104-1-git-send-email-bryan.wu@canonical.com>
	<20100331075746.GO2241@pengutronix.de>
	<20100331081004.GB23391@pengutronix.de>
Message-ID: <20100331081502.GQ2241@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 31, 2010 at 10:10:04AM +0200, Wolfram Sang wrote:
> > With rounding this would be:
> > 
> > (clk_get_rate() + 4999999) / 5000000
> 
> Better use DIV_ROUND_UP(clk_get_rate(), 5000000)?

Yes.
Sometimes I wish the useful assorted kernel helper of the day in my
fortune :)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
