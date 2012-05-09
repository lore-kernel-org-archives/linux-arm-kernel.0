From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 9 May 2012 08:36:17 +0000
Subject: [PATCH 0/3] ARM: OMAP2+: Kconfig: minor cleanup for SOC names
In-Reply-To: <1336514576-4870-1-git-send-email-khilman@ti.com>
References: <1336514576-4870-1-git-send-email-khilman@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1BEA1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 03:32:53, Hilman, Kevin wrote:
> The CONFIG_SOC_* names for do not need an OMAP in the name since
> these are not called OMAP in most places.  Drop the OMAP in the Kconfig
> names to improve readability.
> 
> Also fixes an obvious bug found in the TI81xx code which suggests that
> nobody is using the highest 32 interrupts on these SoCs, or nobody
> is using mainline for TI81xx.
> 
> Kevin Hilman (3):
>   ARM: OMAP2+: INTC: fix Kconfig option for TI81XX
>   ARM: OMAP2+: Kconfig: convert SOC_OMAPTI81XX to SOC_TI81XX
>   ARM: OMAP2+: Kconfig: convert SOC_OMAPAM33XX to SOC_AM33XX
> 
>  arch/arm/mach-omap2/Kconfig  |    8 ++++----
>  arch/arm/mach-omap2/common.h |    4 ++--
>  arch/arm/mach-omap2/io.c     |    8 ++++----
>  arch/arm/mach-omap2/irq.c    |    2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 

Thanks Kevin, this is much needed change. Now it looks straight definitions.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>

Also, I will rebase my patches future patches on top of this.

Thanks,
Vaibhav
