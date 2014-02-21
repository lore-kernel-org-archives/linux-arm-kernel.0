From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 20 Feb 2014 20:41:41 -0500
Subject: [GIT PULL] mvebu: irqchip driver for v3.15
In-Reply-To: <20140217204450.GB7862@titan.lakedaemon.net>
References: <20140217204450.GB7862@titan.lakedaemon.net>
Message-ID: <20140221014141.GY7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Happiness and Joy!

Thomas has taken this into his core branch for v3.15.  Also, I've
achieved new status in the kernel community.  I've made Thomas'
whitelist!  this should prevent problems in the future.

Please disregard the below pull request.

thx,

Jason.

On Mon, Feb 17, 2014 at 03:44:50PM -0500, Jason Cooper wrote:
> Guys,
> 
> Yes, the below is correct.  The original pull request was sent to Thomas
> at the beginning of December.  We emailed back a forth several times,
> with no objection from him.  He just didn't have time to get to it.
> I've replied to the original thread letting him know I was going to go
> ahead and take it through mvebu/arm-soc.  Regrettably, I have to assume
> silence is consent.  I've included him in the Cc: in case he objects.
> 
> We have an arrangement where I put together the mvebu patches for
> irqchip into a branch and send them to him.  Unfortunately, we haven't
> quite worked out what to do when this process fails.
> 
> Obviously, this driver has been in -next for a _long_ time :)  So there
> shouldn't be any hiccups.  I've left it based on v3.13 since that is how
> it's been tested.  Please let me know if that's not ok.
> 
> Despite the tag title, this is now intended for v3.15.
> 
> thx,
> 
> Jason.
> 
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-irqchip-3.14
> 
> for you to fetch changes up to 40b367d95fb3d60fc1edb9ba8f6ef52272e48936:
> 
>   irqchip: irq-dove: Add PMU interrupt controller. (2013-11-26 15:04:53 +0000)
> 
> ----------------------------------------------------------------
> mvebu irqchip changes for v3.14
> 
>  - add Dove PMU interrupt controller
> 
> ----------------------------------------------------------------
> Andrew Lunn (1):
>       irqchip: irq-dove: Add PMU interrupt controller.
> 
>  .../interrupt-controller/marvell,dove-pmu-intc.txt |  17 +++
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-dove.c                         | 126 +++++++++++++++++++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,dove-pmu-intc.txt
>  create mode 100644 drivers/irqchip/irq-dove.c
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
