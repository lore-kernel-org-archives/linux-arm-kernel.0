From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Dec 2011 11:44:37 -0800
Subject: [GIT PULL] ARM perf updates for 3.3
In-Reply-To: <4EDF8512.2030001@arm.com>
References: <20111202170231.GP5540@mudshark.cambridge.arm.com>
 <20111203092659.GL9581@n2100.arm.linux.org.uk>
 <20111205211136.GF14542@n2100.arm.linux.org.uk>
 <20111205231909.GA31337@atomide.com>
 <20111206000232.GC31337@atomide.com>
 <20111206165215.GE31337@atomide.com> <4EDF757B.8020200@ti.com>
 <4EDF8512.2030001@arm.com>
Message-ID: <20111207194436.GI31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [111207 06:52]:
> On 07/12/11 14:17, Cousson, Benoit wrote:
> > 
> > The following commit: 6b2f55d7851aa358d3a99cff344c560c4967f042,
> > is adding the support for the CONFIG_MULTI_IRQ_HANDLER but did
> > not update all the machine descriptors supported in the DT
> > board-generic.c file.
> > It thus break the DT boot on OMAP3 and OMAP4 boards.
> > 
> > Add the proper handle_irq callbacks for OMAP3 and OMAP4 generic
> > machine descriptors.
> > 
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > ---
> >  arch/arm/mach-omap2/board-generic.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks I'll apply this into omap dt branch.

Regards,

Tony
