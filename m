From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 15:03:43 +0200
Subject: [GIT PULL 08/10] Samsung SoC EXYNOS5420 for v3.11
In-Reply-To: <51C0BC74.1060502@samsung.com>
References: <51C0BC74.1060502@samsung.com>
Message-ID: <201306211503.44079.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Kukjin Kim wrote:
> The following changes since commit 79d743c177f99d6854e152d9e7fac5bbbeb7c25e:
> 
>    clk: exynos5250: Add enum entries for divider clock of i2s1 and i2s2 
> (2013-06-19 03:28:43 +0900)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/soc-exynos5420-1
> 
> for you to fetch changes up to eff4e7c7f32a4e4be60b19b209ffab5cb430b385:
> 
>    ARM: EXYNOS: extend soft-reset support for EXYNOS5420 (2013-06-19 
> 04:09:37 +0900)
> 
> ----------------------------------------------------------------
> based on tags/common-clk-audio
> - add support for exynos5420 SoC
> 
> ----------------------------------------------------------------
> Chander Kashyap (10):
>        ARM: dts: fork out common EXYNOS5 nodes
>        ARM: dts: list the CPU nodes for EXYNOS5250
>        ARM: EXYNOS: Add support for EXYNOS5420 SoC
>        serial: samsung: select EXYNOS specific driver data if 
> ARCH_EXYNOS is defined
>        ARM: EXYNOS: use four additional chipid bits to identify EXYNOS 
> family
>        clk: exynos5420: register clocks using common clock framework
>        ARM: dts: Add initial device tree support for EXYNOS5420
>        clocksource: exynos_mct: use (request/free)_irq calls for local 
> timer registration
>        ARM: EXYNOS: add secondary CPU boot base location for EXYNOS5420
>        ARM: EXYNOS: extend soft-reset support for EXYNOS5420
> 

Pulled into next/late now to avoid the dependencies.

	Arnd
