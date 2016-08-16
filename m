From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Aug 2016 09:40:38 +0200
Subject: [PATCH 2/7] Documentation: bindings: Add Exynos5433 PMU compatible
In-Reply-To: <1471328843-26653-3-git-send-email-cw00.choi@samsung.com>
References: <1471328843-26653-1-git-send-email-cw00.choi@samsung.com>
 <1471328843-26653-3-git-send-email-cw00.choi@samsung.com>
Message-ID: <488f925b-4c37-1759-04a8-11d992405527@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/16/2016 08:27 AM, Chanwoo Choi wrote:
> This patch adds the exynos5433 PMU compatible to support the access
> of PMU (Power Management Unit) block.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/pmu.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> index 2d6356d8daf4..bf5fc59a6938 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> @@ -10,6 +10,7 @@ Properties:
>  		   - "samsung,exynos5260-pmu" - for Exynos5260 SoC.
>  		   - "samsung,exynos5410-pmu" - for Exynos5410 SoC,
>  		   - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
> +		   - "samsung,exynos5433-pmu" - for Exynos5433 SoC.
>  		   - "samsung,exynos7-pmu" - for Exynos7 SoC.
>  		second value must be always "syscon".

Is there any plan to add Exynos5433 support to
drivers/soc/samsung/exynos-pmu.c? If no... then exynos7-pmu might be
reused. If yes, then this makes sense.

Best regards,
Krzysztof
