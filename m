From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 27 Oct 2012 19:21:17 +0000
Subject: [PATCH 1/3] irqchip: add basic infrastructure
In-Reply-To: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201210271921.17472.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 October 2012, Thomas Petazzoni wrote:
> With the recent creation of the drivers/irqchip/ directory, it is
> desirable to move irq controller drivers here. At the moment, the only
> driver here is irq-bcm2835, the driver for the irq controller found in
> the ARM BCM2835 SoC, present in Rasberry Pi systems. This irq
> controller driver was exporting its initialization function and its
> irq handling function through a header file in
> <linux/irqchip/bcm2835.h>.

Very nice series!

I think it would be good if Thomas Gleixner as the IRQ subsystem maintainer
could have a look as well. We should probably add the drivers/irqchip
directory to that MAINTAINERS entry.

	Arnd
