From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Dec 2015 15:50:05 -0800
Subject: [GIT PULL] omap fixes against v4.4-rc4
In-Reply-To: <1892295.pQZqt1gEpo@wuerfel>
References: <20151210233907.GI23396@atomide.com> <1892295.pQZqt1gEpo@wuerfel>
Message-ID: <20151210235004.GJ23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [151210 15:46]:
> On Thursday 10 December 2015 15:39:08 Tony Lindgren wrote:
> > Few fixes for omaps for v4.4-rc cycle:
> > 
> > - Fix clock source for ARM TWD and global timers on am437x
> > 
> > - Always select REGULATOR_FIXED_VOLTAGE for omap2+ instead of
> >   when MACH_OMAP3_PANDORA is selected
> > 
> > - Fix SPI DMA handles for dm816x as only some were mapped
> > 
> > - Fix up mbox cells for dm816x to make mailbox usable
> > 
> 
> Just when I had finished pulling in all other fixes and was about
> to go to bed.

Oops sorry I should have sent this earlier today!

> Pulled into fixes, too.

Thanks & good night,

Tony
