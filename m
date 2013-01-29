From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 29 Jan 2013 16:37:21 +0100
Subject: [PATCH v1 1/5] ARM: cache-l2x0: add 'smc' identifier
In-Reply-To: <20130129101328.GA11878@bnru10>
References: <20130129101328.GA11878@bnru10>
Message-ID: <2343104.qToacQ6GEi@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinidhi,

On Tuesday 29 of January 2013 15:43:31 srinidhi kasagar wrote:
> Add 'smc' (Secure Monitor Call) identifier to differentiates
> the platforms which implements this.
> 
> Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi                   |    1 +
>  arch/arm/include/asm/hardware/cache-l2x0.h     |    2 +-
>  arch/arm/mach-cns3xxx/core.c                   |    4 ++--
>  arch/arm/mach-exynos/common.c                  |    4 ++--
>  arch/arm/mach-imx/mm-imx3.c                    |    4 ++--
>  arch/arm/mach-nomadik/cpu-8815.c               |    4 ++--
>  arch/arm/mach-omap2/omap4-common.c             |    2 +-
>  arch/arm/mach-realview/realview_eb.c           |    4 ++--
>  arch/arm/mach-realview/realview_pb1176.c       |    4 ++--
>  arch/arm/mach-realview/realview_pb11mp.c       |    4 ++--
>  arch/arm/mach-realview/realview_pbx.c          |    4 ++--
>  arch/arm/mach-shmobile/board-ag5evm.c          |    2 +-
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    4 ++--
>  arch/arm/mach-shmobile/board-bonito.c          |    4 ++--
>  arch/arm/mach-shmobile/board-kota2.c           |    4 ++--
>  arch/arm/mach-shmobile/board-kzm9g.c           |    4 ++--
>  arch/arm/mach-shmobile/setup-r8a7779.c         |    4 ++--
>  arch/arm/mach-spear13xx/spear13xx.c            |    2 +-
>  arch/arm/mach-ux500/cache-l2x0.c               |    2 +-
>  arch/arm/mach-vexpress/ct-ca9x4.c              |    2 +-
>  arch/arm/mm/cache-l2x0.c                       |   18
> ++++++++++++++---- 21 files changed, 47 insertions(+), 36 deletions(-)

I'd recommend you to take a look at this series:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/202224/

It's already queued up for 3.9 in Samsung tree and most likely provides an 
interface needed for what you want to achieve.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
