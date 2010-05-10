From: peter.pearse@arm.com (Peter Pearse)
Date: Mon, 10 May 2010 16:09:59 +0100
Subject: FW: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
Message-ID: <000101caf052$db991e30$9446010a@Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

> -----Original Message-----
> From: Peter Pearse [mailto:peter.pearse at arm.com] 
> Sent: 07 May 2010 16:01
> To: 'Linus Walleij'
> Cc: linux-arm-kernel at lists.arm.linux.org.uk
> Subject: RE: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
> 
> Linus
> 
> I've applied 
> 
> [PATCH 04/11] ARM: define the PrimeCell DMA API v5
> [PATCH 5/7] ARM: add PrimeCell generic DMA to PL011 v6		
> [PATCH 6/7] ARM: add PrimeCell generic DMA to MMCI/PL180 v6	
> 
> to Russell's versatile tree.
> 
> A Versatile Express board running the resulting kernel image
> 	boots with serial output
> 	accepts serial input
> 	reads & writes an MMC card
> 
> Regards
> 
> Peter
> 
> 
> > -----Original Message-----
> > From: linux-kernel-owner at vger.kernel.org
> > [mailto:linux-kernel-owner at vger.kernel.org] On Behalf Of 
> Linus Walleij
> > Sent: 07 May 2010 10:14
> > To: Dan Williams
> > Cc: Russell King - ARM Linux;
> > linux-arm-kernel at lists.infradead.org;
> > linux-mmc at vger.kernel.org; linux-kernel at vger.kernel.org
> > Subject: Re: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
> > 
> > Dan is this patch set OK?
> > 
> > Sorry if you're busy, just need to check...
> > 
> > Patches 1 thru 4 should be uncontroversial, only affects our 
> > ST-Ericsson platforms and have been thorougly reviewed.
> > 
> > As posted elsewhere this is tested on an ARM reference 
> design now as 
> > well, which IMHO would make it OK to apply also the
> > PL011 patch, nr 5.
> > 
> > (OK Russell?)
> > 
> > Nr 6 and 7 depend on changes in Russells -next branch so unless you 
> > want to bring in the ARM next to your tree as well, you can 
> wait with 
> > these.
> > 
> > Yours,
> > Linus Walleij
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-kernel" in the body of a message to majordomo at vger.kernel.org 
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
