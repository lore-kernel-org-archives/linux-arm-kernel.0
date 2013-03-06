From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Mar 2013 16:59:52 -0800
Subject: [PATCH 5/9] ARM: omap1: add back missing includes
In-Reply-To: <201303052227.33430.arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
 <1362521809-22989-6-git-send-email-arnd@arndb.de>
 <201303052227.33430.arnd@arndb.de>
Message-ID: <20130306005951.GH11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [130305 14:31]:
> On Tuesday 05 March 2013, Arnd Bergmann wrote:
> > The recent reorganization of OMAP header files caused a couple of
> > files that used to be implicitly included now missing from OMAP1.
> > This adds explicit inclusions of mach/irqs.h and mach/hardware.h
> > in all files that need them for an OMAP1 allyesconfig build.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: linux-omap at vger.kernel.org
> > ---
> >  arch/arm/mach-omap1/board-fsample.c  | 1 +
> >  arch/arm/mach-omap1/board-h2.c       | 1 +
> >  arch/arm/mach-omap1/board-perseus2.c | 1 +
> >  arch/arm/mach-omap1/board-sx1.c      | 1 +
> >  drivers/video/omap/lcd_ams_delta.c   | 1 +
> >  drivers/video/omap/lcd_osk.c         | 1 +
> >  6 files changed, 6 insertions(+)
> 
> I saw that Tony has already addressed the latter two changes, but
> did not see a fix for the four board files.

Hmm I wonder why I have not seen the board-*.c related ones?

Anyways thanks for fixing those:

Acked-by: Tony Lindgren <tony@atomide.com>
