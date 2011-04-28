From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 28 Apr 2011 12:47:32 +0200
Subject: [PATCH] PXA: Fix typo in proc-xscale.S
In-Reply-To: <4DB942F3.1070601@compulab.co.il>
References: <1303955164-22197-1-git-send-email-marek.vasut@gmail.com>
	<4DB90DD8.7050406@compulab.co.il>
	<20110428095548.GY17290@n2100.arm.linux.org.uk>
	<4DB942F3.1070601@compulab.co.il>
Message-ID: <20110428104732.GO31131@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

[adding Ben as the author of the linked patch to Cc:]

On Thu, Apr 28, 2011 at 01:35:31PM +0300, Igor Grinberg wrote:
> On 04/28/11 12:55, Russell King - ARM Linux wrote:
> 
> > On Thu, Apr 28, 2011 at 09:48:56AM +0300, Igor Grinberg wrote:
> >> Hi Marek,
> >>
> >> On 04/28/11 04:46, Marek Vasut wrote:
> >>
> >>> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> >>> ---
> >>>  arch/arm/mm/proc-xscale.S |    2 +-
> >>>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
> >>> index ce233bc..42af976 100644
> >>> --- a/arch/arm/mm/proc-xscale.S
> >>> +++ b/arch/arm/mm/proc-xscale.S
> >>> @@ -395,7 +395,7 @@ ENTRY(xscale_dma_a0_map_area)
> >>>  	teq	r2, #DMA_TO_DEVICE
> >>>  	beq	xscale_dma_clean_range
> >>>  	b	xscale_dma_flush_range
> >>> -ENDPROC(xscsale_dma_a0_map_area)
> >>> +ENDPROC(xscale_dma_a0_map_area)
> >>>  
> >>>  /*
> >>>   *	dma_unmap_area(start, size, dir)
> >> Similar patch:
> >> http://www.spinics.net/lists/arm-kernel/msg118258.html
> >>
> >> has been sent to Russell quite a while ago,
> >> but somehow got lost or something.
> > As I keep saying, I'm useless dealing with patches sent only by email -
> > they tend to get quickly buried and forgotten, plus they need saving out,
> > sometimes editing and transferring between machines to be applied.
> >
> > The patch system greatly simplifies that effort, and ensures that patches
> > don't get forgotten.
> 
> Apparently, not many people read Documentation/arm/README :(
> May be it would be helpful to add a note to the MAINTAINERS file
> regarding the patch system and tweak scripts/get_maintainer.pl
> to spit it out in appropriate cases?
another problem is that the patch system is for reviewed patches only.
If the patch is forgotten before it gets some reply sending it to the
patch system is wrong (at least for non-trivial patches).

Patchwork comes to mind. That doesn't forget patches.
I think for that to be practical for lakml some automatic delegation
would be needed though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
