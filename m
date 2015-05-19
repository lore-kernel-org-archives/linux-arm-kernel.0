From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 19 May 2015 14:57:45 +0900
Subject: [PATCH v2 3/4] ARM: multi_v7_defconfig: Enable TMU for Exynos
In-Reply-To: <1431913636-31854-4-git-send-email-k.kozlowski@samsung.com>
References: <1431913636-31854-1-git-send-email-k.kozlowski@samsung.com>
 <1431913636-31854-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <555AD0D9.9060502@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/15 10:47, Krzysztof Kozlowski wrote:
> From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> 
> Enable support for Thermal Monitoring Unit present on Exynos SoCs. This
> allows detection of overheat and handling this gracefully.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Krzysztof, you want to use gmail account on this, you used samsung
accoung on 1st and 2nd patches though?

- Kukjin

> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index f09ae2089284..8fa7171b12f3 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -342,6 +342,7 @@ CONFIG_SENSORS_LM90=y
>  CONFIG_SENSORS_LM95245=y
>  CONFIG_THERMAL=y
>  CONFIG_CPU_THERMAL=y
> +CONFIG_EXYNOS_THERMAL=m
>  CONFIG_RCAR_THERMAL=y
>  CONFIG_ARMADA_THERMAL=y
>  CONFIG_DAVINCI_WATCHDOG
