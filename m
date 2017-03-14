From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 14 Mar 2017 14:00:20 +0100
Subject: [PATCH v2 5/8] ARM: dts: exynos: Enable watchdog on all Exynos4
 boards
In-Reply-To: <20170311172527.16368-6-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-6-krzk@kernel.org>
 <CGME20170314130022epcas5p4e771120ec9ea3f488e1dee644c0b1d07@epcas5p4.samsung.com>
Message-ID: <4885890.jl6tPtmvlV@amdc3058>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Saturday, March 11, 2017 07:25:24 PM Krzysztof Kozlowski wrote:
> Watchdog module does not have external dependencies so it can be safely
> enabled in exynos4.dtsi thus making it available for all Exynos4-based
> boards.

Please fix the patch description (patch #3 moved watchdog node out from
exynos4.dtsi).

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts         | 4 ----
>  arch/arm/boot/dts/exynos4210.dtsi               | 1 -
>  arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 4 ----
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 4 ----
>  arch/arm/boot/dts/exynos4412-origen.dts         | 4 ----
>  arch/arm/boot/dts/exynos4412.dtsi               | 1 -
>  6 files changed, 18 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
