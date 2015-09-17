From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 17 Sep 2015 16:50:37 +0200 (CEST)
Subject: drivers/irqchip patch submission 
Message-ID: <alpine.DEB.2.11.1509171642580.3951@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Folks,

I'm really tired of patches against drivers/irqchip sent to random
mailing lists and later on a ping mail why they are not applied.

Here is the relevant section of MAINTAINERS:

IRQCHIP DRIVERS
M:      Thomas Gleixner <tglx@linutronix.de>
M:      Jason Cooper <jason@lakedaemon.net>
M:      Marc Zyngier <marc.zyngier@arm.com>
L:      linux-kernel at vger.kernel.org
S:      Maintained
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
T:      git git://git.infradead.org/users/jcooper/linux.git irqchip/core
F:      Documentation/devicetree/bindings/interrupt-controller/
F:      drivers/irqchip/

This file is there for a reason and I'm not going to collect irqchip
patches from any other mailing list or from my personal inbox.

It's not that hard really.

Thanks,

	tglx
