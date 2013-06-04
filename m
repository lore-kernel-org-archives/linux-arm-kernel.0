From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 4 Jun 2013 11:25:45 +0000
Subject: [PATCH v2 00/14] ARM: OMAP2+: AM43x initial support
In-Reply-To: <cover.1369658705.git.afzal@ti.com>
References: <cover.1369658705.git.afzal@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EB14140@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, May 27, 2013 at 20:03:27, Mohammed, Afzal wrote:

> This series adds initial support for AM43x based SoC's. To boot
> AM43x, in addition to these patches, PRCM support is also needed,
> which would be posted later as a separate series. DT sources doesn't
> have "ti,hwmod" entry - this would be added along with PRCM support.
> 
> AM43x SoC's are based on ARM Cortex-A9 with one core. AM43x is similar
> to AM335x in it's peripheral capabilities, except a few additional
> ones, with many of the peripheral register mapping's similar. AM43x
> has a sync timer, which is being used as clocksource. Clockevent used
> is 1ms dmtimer.
> 
> SoC has PL310 L2 cache, support for it would be added later.
> 
> soc_is_am43xx() is introduced to handle AM43x specific details and
> soc_is_am437x() is a subclass of it - first member of the class.
> 
> AM43x is currently in pre-silicon stage and currently there are no
> public documents.
> 
> This has been tested on a pre-silicon platform that emulates AM43x SoC
> with additional changes on top of this.
> 
> AM335x based board (AM335x EVM) has been verfied to boot as earlier
> with this series.
> 
> Baseline: v3.10-rc3
> Dependency: "ARM: OMAP3+: am33xx id: Add new am33xx specific function to check dev_feature"
> 		by Vaibhav Hiremath <hvaibhav@ti.com>

If you have any comments on this series please let me know, else if
you are okay with this, please consider patches 1-10 for inclusion
in the coming merge window.

Patch 14/14 has been taken by Benoit and patches 11-13 are to be
dropped (as per discussion in 11/14 thread)

Regards
Afzal
