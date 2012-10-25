From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 25 Oct 2012 20:09:54 +0000 (UTC)
Subject: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources
 pdata function pointer
In-Reply-To: <20121025200812.GC11623@blackmetal.musicnaut.iki.fi>
References: <20121016012448.21844.92339.stgit@dusk.lan>
 <20121016013213.21844.20016.stgit@dusk.lan>
 <20121025153805.GB11623@blackmetal.musicnaut.iki.fi>
 <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com>
 <20121025185755.GV11928@atomide.com>
 <alpine.DEB.2.00.1210251908560.21193@utopia.booyaka.com>
 <20121025191936.GZ11928@atomide.com>
 <alpine.DEB.2.00.1210251929500.21193@utopia.booyaka.com>
 <20121025193413.GA11928@atomide.com>
 <alpine.DEB.2.00.1210251944540.21193@utopia.booyaka.com>
 <20121025200812.GC11623@blackmetal.musicnaut.iki.fi>
Message-ID: <alpine.DEB.2.00.1210252009430.21193@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Oct 2012, Aaro Koskinen wrote:

> On Thu, Oct 25, 2012 at 07:57:31PM +0000, Paul Walmsley wrote:
> > [ As an aside, neither the OMAP watchdog driver, nor the TWL watchdog 
> > driver have been updated to use the new watchdog core code.  So they both 
> > can't be loaded at the same time until one or both are fixed. ]
> 
> FYI, this is being done currently:
> 
> 	- OMAP wdt: https://lkml.org/lkml/2012/10/10/402
> 	- TWL wdt: http://marc.info/?l=linux-omap&m=134734329319385&w=2

Thanks, that's good news.


- Paul
