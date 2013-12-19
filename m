From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 Dec 2013 10:48:15 -0800
Subject: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
In-Reply-To: <1384970958-4118-1-git-send-email-balbi@ti.com>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
Message-ID: <20131219184815.GU27438@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [131120 10:10]:
> Afte these patches, we're very close to being able
> to move arch/arm/mach-omap2/irq.c to drivers/irqchip/irq-intc.c

That would be nice :)
 
> All which would be missing is for Tony to drop all OMAP2/3 board
> files so we remove the few pending bits and pieces left in
> for legacy boot.

That may still need to wait a while, but let's see.
 
> Note that I have only boot tested these on AM335x Bone Black
> (with a small fix for fixed regulator which should be in
> the mailing list already), so I'd need help testing all
> other impacted platforms, specially when it comes to PM.

Sorry have not had much of a chance to test these with PM with
all the fixes needed for omap3 DT mode. Tried testing these
just now, but I get:

arch/arm/mach-omap2/board-generic.c:134: error: ?omap_intc_of_init? undeclared here (not in a function)

Regards,

Tony
