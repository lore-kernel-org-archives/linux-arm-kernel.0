From: khilman@ti.com (Kevin Hilman)
Date: Tue, 04 Jan 2011 14:44:46 -0800
Subject: [PATCH 0/2] OMAP: TWL: sparse fixes
In-Reply-To: <8762u47dmk.fsf@ti.com>
References: <1294081110-23695-1-git-send-email-nm@ti.com>
	<8762u47dmk.fsf@ti.com>
Message-ID: <1294181086.18162.38.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-04 at 10:00 -0800, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > Source:
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> > branch: omap-for-linus
> >
> > Doing a rm arch/arm/mach-omap2/*.o;make C=1 arch/arm/mach-omap2/
> > resulted in the following sparse warnings:
> > http://pastebin.mozilla.org/907954
> >
> > This series fixes the twl warnings
> > Nishanth Menon (2):
> >   OMAP2+: TWL: make conversion routines static
> >   OMAP2+: TWL: include pm header for init protos
> >
> >  arch/arm/mach-omap2/omap_twl.c |   10 ++++++----
> >  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Tony, these should probably queue for .38 if it's not too late.

On second thought, it's too late for the main 2.6.38 merge window for
these.  I'll queue these in my pm-fixes branch for the 2.6.38-rc cycle.

Kevin
