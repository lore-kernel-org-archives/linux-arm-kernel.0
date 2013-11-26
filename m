From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Nov 2013 17:28:52 -0800
Subject: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot
 in DT only mode
In-Reply-To: <20131126010922.GA21580@saruman.home>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <20131126010922.GA21580@saruman.home>
Message-ID: <20131126012851.GC26766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [131125 17:10]:
> On Mon, Nov 25, 2013 at 04:14:15PM -0800, Tony Lindgren wrote:
> > 
> > We can finally make mach-omap2 to boot in device tree only mode for v3.14.
...
> > 
> > Tony Lindgren (12):
> >   ARM: OMAP2+: Remove legacy omap3 board-*.c files and make mach-omap2
> >     DT only for booting
> 
> looks like this patch didn't make it to the list, maybe it's too large ?

Yeah looks like patches 1 and 11 were too bloated. I just posted dietx
versions of those as a reply to this thread that don't yet remove the
legacy board-*.c files and mux*.c files.

Regards,

Tony
