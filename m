From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Oct 2015 18:03:26 +0200
Subject: [GIT PULL] Samsung DT updates for v4.4
In-Reply-To: <561C111F.3060704@kernel.org>
References: <561C111F.3060704@kernel.org>
Message-ID: <41536735.3LmBWhHMre@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 04:59:27 Kukjin Kim wrote:
> Samsung DT updates for v4.4
> 
> - New board support
>   : add exynos5250-snow-rev5 DT file to support Snow Rev5+ board
>   : add exynos5422-odroidxu4 DT file to support Odroid XU4 board
>   : split exynos5422-odroidxu3-audio DT file from odroidxu3-common
> 
> - USE GPIO constants for flags cells for exynos boards
> - fix cpu compatible value to 'arm926ej-s' for s3c2416
> 
> - add DMA support for serial ports for exynos4
> - add suspend opp for exynos4412
> - remove regulator-compatible usage for exynos4412-trats2
> 
> - enable EC vboot context support for Peach boards
> - move display-timings node to DP for exynos5250-arndale, smdk5250 and
> smdk5420
> 
> - for exynos4412-odroid/odroidu3
>   : unify voltage regulator style and
>   : remove redundant pinctrl settings
>   : add pwm-fan node and use it as a colling device
> 
> - for exynos5422-odroidxu3
>   : fix power off method and LEDs
> 
> - dt-bindings
>   : grounded AC0KB pin on S2MPS11
>   : entry how to use PWM FAN as a cooling device

Pulled into next/dt, thanks!

	Arnd
