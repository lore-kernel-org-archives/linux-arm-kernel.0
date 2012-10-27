From: tglx@linutronix.de (Thomas Gleixner)
Date: Sat, 27 Oct 2012 23:31:43 +0200 (CEST)
Subject: [PATCH 1/3] irqchip: add basic infrastructure
In-Reply-To: <201210271921.17472.arnd@arndb.de>
References: <1351356317-16758-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201210271921.17472.arnd@arndb.de>
Message-ID: <alpine.LFD.2.02.1210272329380.2756@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 27 Oct 2012, Arnd Bergmann wrote:

> On Saturday 27 October 2012, Thomas Petazzoni wrote:
> > With the recent creation of the drivers/irqchip/ directory, it is
> > desirable to move irq controller drivers here. At the moment, the only
> > driver here is irq-bcm2835, the driver for the irq controller found in
> > the ARM BCM2835 SoC, present in Rasberry Pi systems. This irq
> > controller driver was exporting its initialization function and its
> > irq handling function through a header file in
> > <linux/irqchip/bcm2835.h>.
> 
> Very nice series!
> 
> I think it would be good if Thomas Gleixner as the IRQ subsystem maintainer
> could have a look as well. We should probably add the drivers/irqchip
> directory to that MAINTAINERS entry.

I skimmed over the patches and they look very reasonable. I try to
find a time slot to give it a more thorough look.

So: Tentatively-acked-by-me
