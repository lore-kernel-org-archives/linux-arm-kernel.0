From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Jul 2012 09:06:37 +0200
Subject: [PATCH 2/2] ARM: mxs: defconfig: Enable CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <20120705063749.GF10610@S2101-09.ap.freescale.net>
References: <1341261351-7924-1-git-send-email-festevam@gmail.com>
 <1341261351-7924-2-git-send-email-festevam@gmail.com>
 <20120705005504.GG2595@S2101-09.ap.freescale.net>
 <20120705062540.GK30009@pengutronix.de>
 <20120705063749.GF10610@S2101-09.ap.freescale.net>
Message-ID: <20120705070637.GN30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 02:37:51PM +0800, Shawn Guo wrote:
> On Thu, Jul 05, 2012 at 08:25:40AM +0200, Sascha Hauer wrote:
> > I also like to have debugfs support enabled in the defconfigs. I don't
> > know if it's desirable to enable this unconditionally when
> > CONFIG_DEBUGFS is enabled because I think the clk debugfs support can
> > have some bad influence on performance.
> > 
> > I think Fabios patches are fine for nor. If we decide to enable clk
> > debugfs support later unconditionally than all we have is two unused
> > lines in the defconfigs.
> > 
> Ok, I will queue both patches then.

Could you skip the imx patch? I also have some patches for the defconfig
from Fabio and I'd like to squash them together since the imx defconfig
could use a general update.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
