From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Jul 2012 08:25:40 +0200
Subject: [PATCH 2/2] ARM: mxs: defconfig: Enable CONFIG_COMMON_CLK_DEBUG
In-Reply-To: <20120705005504.GG2595@S2101-09.ap.freescale.net>
References: <1341261351-7924-1-git-send-email-festevam@gmail.com>
 <1341261351-7924-2-git-send-email-festevam@gmail.com>
 <20120705005504.GG2595@S2101-09.ap.freescale.net>
Message-ID: <20120705062540.GK30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 08:55:06AM +0800, Shawn Guo wrote:
> On Mon, Jul 02, 2012 at 05:35:51PM -0300, Fabio Estevam wrote:
> > From: Fabio Estevam <fabio.estevam@freescale.com>
> > 
> > With the common clock framework in place, it is useful to enable
> > CONFIG_COMMON_CLK_DEBUG option, in order to easily inspect the clock tree.
> > 
> 
> I'm ambiguous on this.  It does look useful, but on the other hand,
> I'm wondering why it hasn't been enabled by framework by default.
> 
> Sascha, what's your take on this?

I also like to have debugfs support enabled in the defconfigs. I don't
know if it's desirable to enable this unconditionally when
CONFIG_DEBUGFS is enabled because I think the clk debugfs support can
have some bad influence on performance.

I think Fabios patches are fine for nor. If we decide to enable clk
debugfs support later unconditionally than all we have is two unused
lines in the defconfigs.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
