From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 May 2013 14:37:07 +0100
Subject: [PATCH 0/9] Important ux500 fixups due for the v3.10 -rc:s
In-Reply-To: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130508133707.GH3459@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Sam, Mike & Ulf

I see that you weren't on the list for the 0/9 patch, so here FYI:

> This patch-set straightens out some serious errors incurred during
> the v3.10 merge window, including:
> 
> Patch 1: Possible over-write of DB8500-PRCMU platform data
> Patch 2: Fail to register AB8500 GPIO driver
> Patch 3: Fail to start Ethernet when using ATAGS - Clocks
> Patch 4: Fail to probe DB8500 Thermal driver - No pdata
> Patch 5: Fail to use Early Printk - Incorrect virtual addresses
> Patch 6: Fail to start Ethernet with using Device Tree - Clocks
> Patch 7: Oops kernel during driver fail - Null pointer
> Patch 8: Fail to probe AB8500 GPIO driver - Incorrect platform ID
> Patch 9: Fail to probe AB8500 GPADC driver - Regulators
> 
>  arch/arm/include/debug/ux500.S     |    6 +++---
>  arch/arm/mach-ux500/board-mop500.c |    6 +++---
>  arch/arm/mach-ux500/cpu-db8500.c   |    6 ++----
>  arch/arm/mach-ux500/setup.h        |    2 +-
>  drivers/clk/ux500/u8500_clk.c      |    2 +-
>  drivers/mfd/ab8500-core.c          |    9 ++++++---
>  drivers/mfd/db8500-prcmu.c         |    1 +
>  drivers/pinctrl/pinctrl-abx500.c   |   30 ++++++++++++++----------------
>  8 files changed, 31 insertions(+), 31 deletions(-)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
