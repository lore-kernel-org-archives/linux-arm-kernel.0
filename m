From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 19 Feb 2016 15:17:26 +0100
Subject: [PATCH v3] irqchip: irq-mvebu-odmi: new driver for platform MSI
 on Marvell 7K/8K
In-Reply-To: <56C72392.5010202@arm.com>
References: <1455888883-5127-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <56C72392.5010202@arm.com>
Message-ID: <20160219151726.418ba46b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Fri, 19 Feb 2016 14:15:46 +0000, Marc Zyngier wrote:

> >  .../marvell,odmi-controller.txt                    |  41 ++++
> >  drivers/irqchip/Kconfig                            |   4 +
> >  drivers/irqchip/Makefile                           |   1 +
> >  drivers/irqchip/irq-mvebu-odmi.c                   | 248 +++++++++++++++++++++
> >  4 files changed, 294 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,odmi-controller.txt
> >  create mode 100644 drivers/irqchip/irq-mvebu-odmi.c
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> I'll queue that for 4.6.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
