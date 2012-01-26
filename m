From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 26 Jan 2012 11:59:42 +0100
Subject: [PATCH] ARM: mxc: add missing include
In-Reply-To: <20120126111011.GA3523@S2101-09.ap.freescale.net>
References: <20120126104306.GE20173@pengutronix.de>
 <20120126111011.GA3523@S2101-09.ap.freescale.net>
Message-ID: <20120126105942.GF20173@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 07:10:14PM +0800, Shawn Guo wrote:
> Fabio had posted a patch below to fix the same issue, which is still
> pending on Sascha to apply.
> 
> http://www.spinics.net/lists/arm-kernel/msg154514.html
> 
> IMO, Fabio's the fixing is better than this patch, since we do not
> necessarily need '__init' annotation for function prototype declaration.

Ok, sounds good.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
