From: mike@compulab.co.il (mike at compulab.co.il)
Date: Fri, 13 May 2011 11:42:08 +0300
Subject: [RESEND PATCH 0/4] omap: merge IGEP v2 and v3
In-Reply-To: <BANLkTi=UpaA6vqxepUCMdi-BVWZxwTuRxQ@mail.gmail.com>
References: <cover.1305235542.git.mike@compulab.co.il>
	<BANLkTi=UpaA6vqxepUCMdi-BVWZxwTuRxQ@mail.gmail.com>
Message-ID: <20110513084208.GA15897@gentoodev.compulab.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric,

On Fri, May 13, 2011 at 09:27:18AM +0200, Enric Balletb?? i Serra wrote:
> Hi Mike,
> 
> 2011/5/12 Mike Rapoport <mike@compulab.co.il>:
> > Hi Tony,
> >
> > I'm resending this with the correct arm-linux mailing list cc'ed..
> > Just discard the first set, sorry for the noise...
> >
> > This is yet another attempt to reduce code duplication in the board files :)
> > Only build tested, since I don't have the hardware, so I belive an Ack from
> > Enric is required.
> 
> Against which tree is based your work ?
 
It's based on devel-cleaup branch in Tony's linux-omap tree.

> Cheers,
>   Enric
> 
> >
> > Mike Rapoport (4):
> > ??omap: igep0020: name refactoring for future merge with IGEP3
> > ??omap: igep0020: minor refactoring
> > ??omap: igep0020: add support for IGEP3
> > ??omap: drop board-igep0030.c
> >
> > ??arch/arm/mach-omap2/Kconfig ?? ?? ?? ?? ??| ?? ??1 +
> > ??arch/arm/mach-omap2/Makefile ?? ?? ?? ?? | ?? ??2 -
> > ??arch/arm/mach-omap2/board-igep0020.c | ??286 +++++++++++++---------
> > ??arch/arm/mach-omap2/board-igep0030.c | ??438 ----------------------------------
> > ??4 files changed, 174 insertions(+), 553 deletions(-)
> > ??delete mode 100644 arch/arm/mach-omap2/board-igep0030.c
> >
> > --
> > 1.7.3.1
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
