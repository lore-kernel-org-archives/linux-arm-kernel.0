From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Jul 2017 07:14:27 +0200
Subject: [PATCH] ARM: dts: exynos: remove num-slots from exynos platforms
In-Reply-To: <1499160322-73008-1-git-send-email-shawn.lin@rock-chips.com>
References: <1499160322-73008-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20170718051427.GA22637@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 05:25:22PM +0800, Shawn Lin wrote:
> dwmmc driver deprecated num-slots and plan to get rid
> of it finally. Just move a step to cleanup it from DT.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  arch/arm/boot/dts/exynos3250-artik5-eval.dts    | 1 -
>  arch/arm/boot/dts/exynos3250-artik5.dtsi        | 1 -
>  arch/arm/boot/dts/exynos3250-monk.dts           | 1 -
>  arch/arm/boot/dts/exynos3250-rinato.dts         | 1 -
>  arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 1 -
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 -
>  arch/arm/boot/dts/exynos4412-origen.dts         | 1 -
>  arch/arm/boot/dts/exynos4412-trats2.dts         | 1 -
>  arch/arm/boot/dts/exynos5250-arndale.dts        | 2 --
>  arch/arm/boot/dts/exynos5250-smdk5250.dts       | 2 --
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi   | 3 ---
>  arch/arm/boot/dts/exynos5250-spring.dts         | 2 --
>  arch/arm/boot/dts/exynos5260-xyref5260.dts      | 2 --
>  arch/arm/boot/dts/exynos5410-smdk5410.dts       | 2 --
>  arch/arm/boot/dts/exynos5420-peach-pit.dts      | 3 ---
>  arch/arm/boot/dts/exynos5800-peach-pi.dts       | 3 ---
>  16 files changed, 27 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
