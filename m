From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 12 Jul 2011 15:50:46 +0200
Subject: [PATCH] i.MX53: Initial Ka-Ro electronics TX53 board support
In-Reply-To: <20110712115146.GC19105@S2100-06.ap.freescale.net>
References: <1310469518-23615-1-git-send-email-LW@KARO-electronics.de>
	<20110712115146.GC19105@S2100-06.ap.freescale.net>
Message-ID: <20110712135046.GU6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2011 at 07:51:47PM +0800, Shawn Guo wrote:
> On Tue, Jul 12, 2011 at 01:18:38PM +0200, Lothar Wa?mann wrote:
> > This patch adds initial board support for the Ka-Ro electronics TX53
> > processor module (MACH_TX53).
> > 
> > Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> > ---
> >  arch/arm/mach-mx5/Kconfig                   |   15 +
> >  arch/arm/mach-mx5/Makefile                  |    1 +
> >  arch/arm/mach-mx5/board-tx53.c              |  400 +++++++++++++++++++++++++++
> >  arch/arm/plat-mxc/include/mach/uncompress.h |    1 +
> >  4 files changed, 417 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-mx5/board-tx53.c
> > 
> I'm not sure if it makes sense to add another board support, while
> we are migrating to device tree.

I would agree if device tree was complete, but do we really want to
block all new boards for unspecified time?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
