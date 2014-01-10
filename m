From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 10 Jan 2014 13:34:30 -0500
Subject: [GIT PULL] irqchip: dove: drivers for v3.14
In-Reply-To: <20131211175037.GY10053@titan.lakedaemon.net>
References: <20131201172914.GV2879@titan.lakedaemon.net>
 <20131211175037.GY10053@titan.lakedaemon.net>
Message-ID: <20140110183430.GO19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Wed, Dec 11, 2013 at 12:50:37PM -0500, Jason Cooper wrote:
> On Sun, Dec 01, 2013 at 12:29:14PM -0500, Jason Cooper wrote:
> > Here's an mvebu driver we've had on the ML for a while, and it's been in
> > -next for 5 days.
> 
> Just checking to make sure this hasn't slipped off of your plate.
> 

I'm not able to see where this one might have been pulled, could you
please pull or let me know if it's not acceptable?

thx,

Jason.

> > The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> > 
> >   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> > 
> > are available in the git repository at:
> > 
> >   git://git.infradead.org/linux-mvebu.git tags/mvebu-irqchip-3.14
> > 
> > for you to fetch changes up to 40b367d95fb3d60fc1edb9ba8f6ef52272e48936:
> > 
> >   irqchip: irq-dove: Add PMU interrupt controller. (2013-11-26 15:04:53 +0000)
> > 
> > ----------------------------------------------------------------
> > mvebu irqchip changes for v3.14
> > 
> >  - add Dove PMU interrupt controller
> > 
> > ----------------------------------------------------------------
> > Andrew Lunn (1):
> >       irqchip: irq-dove: Add PMU interrupt controller.
> > 
> >  .../interrupt-controller/marvell,dove-pmu-intc.txt |  17 +++
> >  drivers/irqchip/Makefile                           |   1 +
> >  drivers/irqchip/irq-dove.c                         | 126 +++++++++++++++++++++
> >  3 files changed, 144 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,dove-pmu-intc.txt
> >  create mode 100644 drivers/irqchip/irq-dove.c
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
