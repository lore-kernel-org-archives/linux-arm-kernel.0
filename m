From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 May 2011 14:13:10 +0200
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <20110518152237.GA26055@S2100-06.ap.freescale.net>
References: <201105181047.17309.arnd@arndb.de>
	<20110518152237.GA26055@S2100-06.ap.freescale.net>
Message-ID: <201105191413.10480.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 May 2011, Shawn Guo wrote:
> On Wed, May 18, 2011 at 10:47:16AM +0200, Arnd Bergmann wrote:
> [...]
> > +ARM SUBARCHITECTURES
> > +M:	Arnd Bergmann <arnd@arndb.de>
> > +M:	Nicolas Pitre <nico@fluxnic.net>
> > +M:	Thomas Gleixner <tglx@linutronix.de>
> > +M:	arm at kernel.org
> > +L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> > +S:	MAINTAINED
> > +F:	arch/arm/mach-*/
> > +F:	arch/arm/plat-*/
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-subarch.git
> 
> Is this repository ready for use yet?  It seems not for me.

No, not yet. Once we are sure about the initial set of people in the group,
we can set up the arm at kernel.org alias and the group that lets us write
into the /pub/scm/linux/kernel/git/arm directory.

Also, I wouldn't mind changing the name, if someone comes up with a better
term than arm-subarch.git.

	Arnd
