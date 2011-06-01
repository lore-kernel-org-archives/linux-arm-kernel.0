From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 1 Jun 2011 14:35:22 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110530075745.GA31492@S2100-06.ap.freescale.net>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
Message-ID: <20110601123522.GE23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Mon, May 30, 2011 at 03:57:45PM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> I will shortly send move-mxc-gpio-to-drivers patch based on this
> series to save some CONFIG_SOC/ARCH_XXX.  Please let me know if you
> do not think this series is a good base to start with.

This series should be orthogonal to yours. I will prepare an update to
this series. In particular I'm not comfortable with breaking uImage
support. I will follow Uwes recomendation and add an additional level
of dependencies to compile the kernel without physoffset patching.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
