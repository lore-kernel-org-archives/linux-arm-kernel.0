From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 27 Aug 2014 16:03:22 +0200 (CEST)
Subject: [RESEND PATCH v2 1/4] irqchip: gic: Change irq type check when
 extension is present
In-Reply-To: <87ppfmoxxz.fsf@approximate.cambridge.arm.com>
References: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1407895884-18131-2-git-send-email-srv_yingjoe.chen@mediatek.com>
 <53F724F5.3040004@arm.com>
 <1409133344.25382.37.camel@coredoba.hi.pengutronix.de>
 <53FDB4B3.6000400@arm.com>
 <alpine.DEB.2.10.1408271347210.3323@nanos>
 <87ppfmoxxz.fsf@approximate.cambridge.arm.com>
Message-ID: <alpine.DEB.2.10.1408271556350.3323@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Aug 2014, Marc Zyngier wrote:
> I very much like that kind of approach. Stacking domains seems to solve
> a number of issues at once:
> 
> - NVIDIA's gic extension
> - TI's crossbar
> - ARM's GICv2m
> - Mediatek's glorified line inverter
> - ... and probably the next madness that's going to land tomorrow

Its probably already there you just don't know about it yet :)
 
> I haven't completly groked the way we're going to allocate domains and
> irq_data structures, but this is definitely something worth

All we have for now is a rough idea and some pseudo code in my lengthy
reply to Jiang, but it shouldn't be hard to implement something
useful.

Thanks,

	tglx
