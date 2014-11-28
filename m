From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 13:30:51 +0100
Subject: [GIT PULL 3/4] Samsung 3rd round of DT updates for v3.19
In-Reply-To: <5476CD82.5050705@kernel.org>
References: <5476CD82.5050705@kernel.org>
Message-ID: <201411281330.52164.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014, Kukjin Kim wrote:
> Samsung 3rd DT updates for v3.19
> 
> - exynos3250
>   : remove unused bootargs on exynos3250-rinato
>   : add new board dt file for exynos3250-monk
> - exynos4
>   : add missing clock for MFC
>   : specify default clocks for camera
> - exynos4x12
>   : add TMU related DT nodes
> - exynos4412-trats2
>   : add max77693-haptic and pwm nodes, enable TMU support
> - exynos4412-odroid
>   : specify audio clock parents and rates
> - exynos5250 and exynos5420
>   : add syscon based phandle to i2c device nodes
> - exynos5250-spring
>   : add trackpad, temperature sensor and usb3505 pinctrl
> 
> Note: based on previous tags/samsung-dt-2 for v3.19

Pulled into next/dt, thanks!

	Arnd
