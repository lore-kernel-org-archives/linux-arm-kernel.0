From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Aug 2012 09:41:22 +0200
Subject: mxc_nand.c on mach-imx/imx53
In-Reply-To: <5035F84E.3000901@antcom.de>
References: <5035F84E.3000901@antcom.de>
Message-ID: <20120829074122.GV26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roland,

On Thu, Aug 23, 2012 at 11:30:54AM +0200, Roland Stigge wrote:
> Hi,
> 
> I'd like to know about the current state of mxc_nand.c on imx53, because
> I got an error on probe() because the clock that mxc_nand is requesting
> is "nfc" but imx53 only defines the clock "mxc_nand".

The driver generally works on i.MX53, only some pieces are missing. I
just resent the corresponding series and put you on Cc.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
