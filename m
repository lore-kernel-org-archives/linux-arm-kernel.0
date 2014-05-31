From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 May 2014 21:39:58 -0700
Subject: [GIT PULL 2/5] Samsung DT updates for 3.16
In-Reply-To: <5388E31C.5070903@samsung.com>
References: <5388E31C.5070903@samsung.com>
Message-ID: <20140531043958.GB21917@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 04:59:24AM +0900, Kukjin Kim wrote:
> The following changes since commit 3c8977f17796f0b8816a1a283b0b80b71c83d416:
> 
>   ARM: dts: enable usb nodes for exynos4412-trats2 (2014-05-23
> 03:31:33 +0900)
> 
> are available in the git repository at:
> 

> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-dt-3
> 
> for you to fetch changes up to 345e9bf08276395bd6620dfab56d1b679136d2ce:
> 
>   ARM: dts: add secure firmware support for exynos5420-arndale-octa
> (2014-05-31 04:03:31 +0900)
> 
> ----------------------------------------------------------------
> Samsung 3rd DT updates for v3.16
> 
> - add dts files support for new SoCs
>   : exynos3250 SoC
>   : exynos5260 SoC and exynos5260-xyref5260 board
>   : exynos5410 SoC and exynos5410-smdk5410 board
>   : exynos5800 SoC and exynos5800-peach-pi board
> 
> - exynos4210-origen and exynos4412-origen
>   : enable RTC and WDT nodes
>   : use key code macros
> 
> - exynos5250-arndale
>   : use key code macros
> 
> - exynos5420-arndale-octa
>   : add secure firmware support
> 
> - exynos5440
>   : update watchdog node name

Much better! Thanks. Merged.


-Olof
