From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Nov 2018 09:03:33 -0800
Subject: Subject: [PATCH v4 0/4] mtd: rawnand: ams-delta: Use GPIO API
 for data I/O
In-Reply-To: <20181121155639.77873f7f@bbrezillon>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20181121110806.32076-1-jmkrzyszt@gmail.com>
 <20181121155639.77873f7f@bbrezillon>
Message-ID: <20181123170333.GH53235@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Boris Brezillon <boris.brezillon@bootlin.com> [181121 14:56]:
> On Wed, 21 Nov 2018 12:08:02 +0100
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Finalize implementation of the idea suggested by Artem Bityutskiy and
> > Tony Lindgren, described in commit b027274d2e3a ("mtd: ams-delta: fix
> > request_mem_region() failure"). Use pure GPIO consumer API, as reqested
> > by Boris Brezillon.
> > 
> > Janusz Krzysztofik (4):
> >       ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND data port
> >       mtd: rawnand: ams-delta: Request data port GPIO resource
> >       mtd: rawnand: ams-delta: Use GPIO API for data I/O
> >       ARM: OMAP1: ams-delta: Drop obsolete NAND resources
> > 
> >  arch/arm/mach-omap1/board-ams-delta.c |   22 ++----
> >  drivers/mtd/nand/raw/ams-delta.c      |  120 +++++++++++++++++++---------------
> >  2 files changed, 80 insertions(+), 62 deletions(-)
> > 
> > Performance on Amstrad Delta is now acceptable after recent extensions
> > to GPIO API and rawnanad enhancements.
> > 
> > Series intented to be merged via mtd tree, should not conflict with
> > other OMAP1 patches submitted for 4.21.
> 
> We'll prepare an immutable tag, just in case.

Sounds good to me thanks:

Acked-by: Tony Lindgren <tony@atomide.com>
