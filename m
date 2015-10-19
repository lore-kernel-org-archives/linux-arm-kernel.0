From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 19 Oct 2015 15:54:55 +0900
Subject: [PATCH 0/7] Switch to generic syscon regmap based drivers
In-Reply-To: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
References: <1445234635-3950-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <562493BF.9080301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.10.2015 15:03, Alim Akhtar wrote:
...

Hi,

I am happy to see more contributions from your side! Keep it up. :)

However this empty space in your cover letter is the place for
description of the patchset. What do you want to achieve here? What kind
of problem are you solving? What features are you adding? Any dependencies?

Best regards,
Krzysztof

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
