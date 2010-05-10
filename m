From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 May 2010 16:18:27 +0100
Subject: FW: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
In-Reply-To: <000101caf052$db991e30$9446010a@Emea.Arm.com>
References: <000101caf052$db991e30$9446010a@Emea.Arm.com>
Message-ID: <20100510151827.GA4281@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 10, 2010 at 04:09:59PM +0100, Peter Pearse wrote:
>  
> 
> > -----Original Message-----
> > From: Peter Pearse [mailto:peter.pearse at arm.com] 
> > Sent: 07 May 2010 16:01
> > To: 'Linus Walleij'
> > Cc: linux-arm-kernel at lists.arm.linux.org.uk
> > Subject: RE: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
> > 
> > Linus
> > 
> > I've applied 
> > 
> > [PATCH 04/11] ARM: define the PrimeCell DMA API v5
> > [PATCH 5/7] ARM: add PrimeCell generic DMA to PL011 v6		
> > [PATCH 6/7] ARM: add PrimeCell generic DMA to MMCI/PL180 v6	
> > 
> > to Russell's versatile tree.
> > 
> > A Versatile Express board running the resulting kernel image
> > 	boots with serial output
> > 	accepts serial input
> > 	reads & writes an MMC card

To be clear, what I'm *not* interested in is whether the primecell
drivers work without DMA support implemented on the platform.

What I *am* interested in is whether Versatile _with_ DMA support
implemented - with the added problems of the MUX in the system
controller - can work sanely with this "generic Primecell DMA"
implementation.
