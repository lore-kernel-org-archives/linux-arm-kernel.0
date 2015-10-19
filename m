From: tjakobi@math.uni-bielefeld.de (Tobias Jakobi)
Date: Mon, 19 Oct 2015 18:08:01 +0200
Subject: [PATCH 0/7] Switch to generic syscon regmap based drivers
In-Reply-To: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <56251561.4010209@math.uni-bielefeld.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

I tested the Exynos4 bits on a Odroid-X2 and I can confirm that
poweroff/reboot (still) work.

With best wishes,
Tobias


Alim Akhtar wrote:
> Alim Akhtar (7):
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos3250 SoCs
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos4
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5
>   arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 SoC
>   ARM: exynos_defconfig: Normalize exynos defconfig
>   ARM: exynos_defconfig: Enable generic syscon-{reboot, poweroff}
>     drivers
>   ARM: EXYNOS: Remove code for restart and poweroff for exynos SoCs
> 
>  arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++
>  arch/arm/boot/dts/exynos4.dtsi    |   14 ++++++++++++
>  arch/arm/boot/dts/exynos5.dtsi    |   14 ++++++++++++
>  arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++
>  arch/arm/configs/exynos_defconfig |   11 +++++-----
>  arch/arm/mach-exynos/pmu.c        |   43 -------------------------------------
>  6 files changed, 61 insertions(+), 49 deletions(-)
> 
