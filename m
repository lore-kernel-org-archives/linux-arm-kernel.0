From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jul 2012 15:39:42 +0000
Subject: [ACKed PATCH] clocksource: dw_apb_timer: Add common DTS glue for
 dw_apb_timer
In-Reply-To: <20120712132809.GD11798@elf.ucw.cz>
References: <1342037596-17710-1-git-send-email-dinguyen@altera.com>
 <alpine.LFD.2.02.1207112307061.32033@ionos>
 <20120712132809.GD11798@elf.ucw.cz>
Message-ID: <201207121539.42608.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 July 2012, Pavel Machek wrote:
> On Wed 2012-07-11 23:10:43, Thomas Gleixner wrote:
> > On Wed, 11 Jul 2012, dinguyen at altera.com wrote:
> > 
> > > From: Dinh Nguyen <dinguyen@altera.com>
> > > 
> > > Make a common device tree glue for clocksource/dw_apb_timer.
> > > Move mach-picoxcell/time.c to be a generic device tree application
> > > of the dw_apb_timer.
> > > 
> > > Configure mach-picoxcell to use the dw_apb_timer_of device tree
> > > implementation in drivers/clocksource.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@denx.de>
> > > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > > Acked-by: Jamie Iles <jamie@jamieiles.com>
> > 
> > Acked-by: Thomas Gleixner <tglx@linutronix.de>
> > 
> > Please take it through the proper ARM/SoC tree so work depending on
> > that does not get blocked.
> 
> Arnd, can you apply this? Or should we create public git tree to pull
> from?


Applied to next/timer branch,

Thanks!

	ARnd
