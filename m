From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 18:59:08 +0100
Subject: [PATCH 6/6] dt: Update binding information for mvebu gating
 clocks with Armada 380/385
In-Reply-To: <20140210175350.GD9995@lunn.ch>
References: <1392053569-28037-1-git-send-email-gregory.clement@free-electrons.com>
 <1392053569-28037-7-git-send-email-gregory.clement@free-electrons.com>
 <20140210175350.GD9995@lunn.ch>
Message-ID: <20140210185908.3374eaf6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 10 Feb 2014 18:53:50 +0100, Andrew Lunn wrote:
> > +The following is a list of provided IDs for Armada 380/385:
> > +ID	Clock		Peripheral
> > +-----------------------------------
> > +0	audio		Audio
> > +2	ge2		Gigabit Ethernet 2
> > +3	ge1		Gigabit Ethernet 1
> > +4	ge0		Gigabit Ethernet 0
> > +5	pex1		PCIe 1
> > +6	pex2		PCIe 2
> > +7	pex3		PCIe 3
> > +8	pex4		PCIe 0
> 
> Is that last one a typo? It at least looks a bit odd.

Right, this should be:

	8	pex0		PCIe 0

(just checked again in the datasheet)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
