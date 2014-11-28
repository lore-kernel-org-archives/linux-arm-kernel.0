From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 13:20:10 +0100
Subject: [GIT PULL 5/5] Samsung exynos updates for v3.19
In-Reply-To: <546F493B.50605@kernel.org>
References: <546F493B.50605@kernel.org>
Message-ID: <201411281320.10442.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014, Kukjin Kim wrote:
> Samsung exynos updates in arch/arm/mach-exynos/ for v3.19
> 
> - add SOC_EXYNOS4415 config to be used in audio driver
> - add support platform driver for exynos PMU
> - move PMU specific definitions from common.h to exynos-pmu.h
> - for exynos5420, add support PMU and Suspend-to-RAM
>   use MCPM call backs and call regulator core suspend prepare
>   and finish functions

Pulled into next/soc, thanks!

	Arnd
