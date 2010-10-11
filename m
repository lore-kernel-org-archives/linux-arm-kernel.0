From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 11 Oct 2010 16:23:11 +0900
Subject: [PATCH v2]  ARM: S5PC210: I2C devices updates
In-Reply-To: <1286455601-25360-1-git-send-email-m.szyprowski@samsung.com>
References: <1286455601-25360-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <009101cb6915$2c89f720$859de560$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
> This is an updated version of I2C patches posted by Kyungmin Park in
> '[PATCH 0/7] ARM: S5PC210: I2C devices support and Universal board
> updates' thread.
> 
> All issues related to i2c device definitions reported by Kukjin Kim have
> been fixed. We also merged some of the patches together to avoid build
> breaks.
> 
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
> 
> ---
> 
> Patch summary:
> 
> Kyungmin Park (3):
>   ARM: S5PC110: Fix wrong interrupt I2C2 and I2C3 number
>   ARM: S5PC210: Define address & interrupt for all I2C blocks
>   ARM: S5PC210: add I2C{3, 4, 5, 6, 7} device support
> 
>  arch/arm/mach-s5pv210/include/mach/irqs.h |    4 +-
>  arch/arm/mach-s5pv310/Kconfig             |   25 +++++++++++
>  arch/arm/mach-s5pv310/Makefile            |    5 ++
>  arch/arm/mach-s5pv310/include/mach/irqs.h |    7 +++
>  arch/arm/mach-s5pv310/include/mach/map.h  |   11 ++++-
>  arch/arm/mach-s5pv310/setup-i2c3.c        |   25 +++++++++++
>  arch/arm/mach-s5pv310/setup-i2c4.c        |   25 +++++++++++
>  arch/arm/mach-s5pv310/setup-i2c5.c        |   25 +++++++++++
>  arch/arm/mach-s5pv310/setup-i2c6.c        |   25 +++++++++++
>  arch/arm/mach-s5pv310/setup-i2c7.c        |   25 +++++++++++
>  arch/arm/plat-samsung/Kconfig             |   25 +++++++++++
>  arch/arm/plat-samsung/Makefile            |    5 ++
>  arch/arm/plat-samsung/dev-i2c2.c          |    4 +-
>  arch/arm/plat-samsung/dev-i2c3.c          |   68
> +++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/dev-i2c4.c          |   68
> +++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/dev-i2c5.c          |   68
> +++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/dev-i2c6.c          |   68
> +++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/dev-i2c7.c          |   68
> +++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/iic.h  |    5 ++
>  19 files changed, 550 insertions(+), 6 deletions(-)
>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c3.c
>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c4.c
>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c5.c
>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c6.c
>  create mode 100644 arch/arm/mach-s5pv310/setup-i2c7.c
>  create mode 100644 arch/arm/plat-samsung/dev-i2c3.c
>  create mode 100644 arch/arm/plat-samsung/dev-i2c4.c
>  create mode 100644 arch/arm/plat-samsung/dev-i2c5.c
>  create mode 100644 arch/arm/plat-samsung/dev-i2c6.c
>  create mode 100644 arch/arm/plat-samsung/dev-i2c7.c
> 
> --

Ok...will apply...but we need to sort out this next time.
And need to change C100 IRQ names...will submit it myself.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
