From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 10 Feb 2016 15:00:46 +0100
Subject: [PATCH v2 0/6] irqchip: irq-armada-370-xp: generic MSI
 infrastructure and assorted fixes
In-Reply-To: <1453899395-3532-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1453899395-3532-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160210150046.118fc991@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 27 Jan 2016 13:56:29 +0100, Thomas Petazzoni wrote:

> Thomas Petazzoni (6):
>   irqchip: irq-armada-370-xp: add Kconfig option for the driver
>   irqchip: irq-armada-370-xp: use the generic MSI infrastructure
>   irqchip: irq-armada-370-xp: use PCI_MSI_DOORBELL_START where
>     appropriate
>   irqchip: irq-armada-370-xp: use shorter names for irq_chip
>   irqchip: irq-armada-370-xp: allow allocation of multiple MSIs
>   ARM: mvebu: use the ARMADA_370_XP_IRQ option

Jason, Thomas, any chance to get this applied soonish?

The core patch of the series, which migrates the irq-armada-370-xp
driver to use the generic MSI infrastructure has been Reviewed-by: Marc
Zyngier, and the other patches in the series have Acked-by/Reviewed-by
from Gregory Clement.

Of course, if there's anything left to be changed, I'd be happy to
respin a new version of this series.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
