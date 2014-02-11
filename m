From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 11 Feb 2014 14:06:32 -0500
Subject: [PATCH 6/6] dt: Update binding information for mvebu gating
 clocks with Armada 380/385
In-Reply-To: <20140210185908.3374eaf6@skate>
References: <1392053569-28037-1-git-send-email-gregory.clement@free-electrons.com>
 <1392053569-28037-7-git-send-email-gregory.clement@free-electrons.com>
 <20140210175350.GD9995@lunn.ch> <20140210185908.3374eaf6@skate>
Message-ID: <20140211190632.GE27395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 06:59:08PM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Mon, 10 Feb 2014 18:53:50 +0100, Andrew Lunn wrote:
> > > +The following is a list of provided IDs for Armada 380/385:
> > > +ID	Clock		Peripheral
> > > +-----------------------------------
> > > +0	audio		Audio
> > > +2	ge2		Gigabit Ethernet 2
> > > +3	ge1		Gigabit Ethernet 1
> > > +4	ge0		Gigabit Ethernet 0
> > > +5	pex1		PCIe 1
> > > +6	pex2		PCIe 2
> > > +7	pex3		PCIe 3
> > > +8	pex4		PCIe 0
> > 
> > Is that last one a typo? It at least looks a bit odd.
> 
> Right, this should be:
> 
> 	8	pex0		PCIe 0
> 
> (just checked again in the datasheet)

I can fix this up when I pull it in for Mike.  No need to redo the
series just for this.

I'll let it sit for a day or two more before I pull it to give everyone
a chance to look it over.

thx,

Jason.

> 
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
