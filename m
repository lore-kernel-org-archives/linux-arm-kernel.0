From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 05 Nov 2011 12:37:47 +0900
Subject: [PATCH] ARM: EXYNOS4: Add SPI support
In-Reply-To: <1320411606-11518-2-git-send-email-padma.v@samsung.com>
References: <1320411606-11518-1-git-send-email-padma.v@samsung.com>
	<1320411606-11518-2-git-send-email-padma.v@samsung.com>
Message-ID: <02eb01cc9b6c$4937aae0$dba700a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi Venna wrote:
> 
> Add SPI setup files for GPIO configurations.
> Add SPI clkdev support.
> Initialize SPI platform specific code in the machine file.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  arch/arm/mach-exynos4/Kconfig                   |    5 ++
>  arch/arm/mach-exynos4/Makefile                  |    1 +
>  arch/arm/mach-exynos4/clock.c                   |   72 +++++++++++++-----
> ----
>  arch/arm/mach-exynos4/include/mach/irqs.h       |    3 +
>  arch/arm/mach-exynos4/include/mach/map.h        |    6 ++
>  arch/arm/mach-exynos4/include/mach/spi-clocks.h |   16 +++++
>  arch/arm/mach-exynos4/mach-smdkv310.c           |   35 +++++++++++
>  arch/arm/mach-exynos4/setup-spi.c               |   47 +++++++++++++++
>  8 files changed, 155 insertions(+), 30 deletions(-)
>  create mode 100644 arch/arm/mach-exynos4/include/mach/spi-clocks.h
>  create mode 100644 arch/arm/mach-exynos4/setup-spi.c
> 
The mach-exynos4 directory will be re-organized in this merge window. So
maybe you need to wait for v3.2-rc1.

And I will be on this after that :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
