From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Apr 2011 18:44:59 +0100
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <201104011750.17344.arnd@arndb.de>
References: <alpine.LFD.2.00.1103310145390.28032@xanadu.home>
	<201104011659.40443.arnd@arndb.de> <4D95EF8E.9080902@vollmann.ch>
	<201104011750.17344.arnd@arndb.de>
Message-ID: <20110401174459.GA8615@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2011 at 05:50:17PM +0200, Arnd Bergmann wrote:
> On Friday 01 April 2011, Detlef Vollmann wrote:
> > On 04/01/11 16:59, Arnd Bergmann wrote:
> > > On Friday 01 April 2011, Detlef Vollmann wrote:
> > >> On 04/01/11 15:54, Arnd Bergmann wrote:
> > >
> > >>> 9. All interesting work is going into a handful of platforms, all of which
> > >>>      are ARMv7 based.
> > >> Define interesting.
> > >
> > > The ones that are causing the churn that we're talking about.
> > > Platforms that have been working forever and only need to get
> > > the occasional bug fix are boring, i.e. not the problem.
> > In the ARM tree I only know mach-at91.
> > Atmel still introduces new SOCs based on ARM926EJ-S, and that makes
> > perfect sense for lots of applications.
> 
> I thought new ones were generally Cortex-M3 based. Either way, even
> if there are exceptions, focusing on ARMv7 at first should give
> a good representation of the new development.

If they're M3 then they're a microcontroller, and so would be using uclinux.
