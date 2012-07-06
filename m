From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Jul 2012 12:36:49 +0200
Subject: Passing GPIO irq edge/level flags from devicetree to driver, how?
In-Reply-To: <20120706081651.GC22133@S2101-09.ap.freescale.net>
References: <20120706075434.GE30009@pengutronix.de>
 <20120706081651.GC22133@S2101-09.ap.freescale.net>
Message-ID: <20120706103649.GG30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 04:16:53PM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> Try to change the value of #interrupt-cells under gpio node from 1 to 2.
> 
> I forgot updating imx on this.

Ok, that does the trick. Should I create a patch or are you already in
the middle of doing so?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
