From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Apr 2011 09:23:18 +0200
Subject: [patch 08/16] arm: pxa: Use clocksource based sched_clock
In-Reply-To: <alpine.DEB.2.00.1104260023080.27645@localhost6.localdomain6>
References: <20110423205036.795894921@linutronix.de>
	<20110423205132.325774191@linutronix.de>
	<alpine.DEB.2.00.1104260023080.27645@localhost6.localdomain6>
Message-ID: <20110426072318.GJ14770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,

On Tue, Apr 26, 2011 at 12:25:45AM +0800, Eric wrote:
> 
> 
> On Sat, 23 Apr 2011, Thomas Gleixner wrote:
> 
> >Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >---
> >arch/arm/mach-pxa/time.c |   31 +++----------------------------
> 
> I think we need to remove HAVE_SCHED_CLOCK from ARCH_PXA in
> arch/arm/Kconfig as well.
> 
> Didn't look into other sub-arch, but should be applicable to those
> selecting HAVE_SCHED_CLOCK.

Thomas already did this. See 16/16

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
