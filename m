From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 3 Dec 2009 20:33:21 +0100
Subject: [PATCH] mx31moboard: fix typo
In-Reply-To: <20091203193034.GD22533@pengutronix.de>
References: <20091203193034.GD22533@pengutronix.de>
Message-ID: <20091203193321.GE22533@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 08:30:34PM +0100, Robert Schwebel wrote:
> Currently, linux-next breaks due to a typo introduced in commit
> 33c4d91928bea4444b067e620496befbeb87029c
> 
> This patch fixes it.

But something else must be missing, I still get this:

arch/arm/mach-mx3/mx31moboard.c: In function 'moboard_usbh2_init':
arch/arm/mach-mx3/mx31moboard.c:395: error: 'mx31_usbh2' undeclared (first use in this function)
arch/arm/mach-mx3/mx31moboard.c:395: error: (Each undeclared identifier is reported only once
arch/arm/mach-mx3/mx31moboard.c:395: error: for each function it appears in.)
make[1]: *** [arch/arm/mach-mx3/mx31moboard.o] Error 1

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
