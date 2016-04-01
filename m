From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 1 Apr 2016 10:38:32 -0400
Subject: [PATCH 05/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Exynos4x12
In-Reply-To: <1459493874-2366-5-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <1459493874-2366-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56FE87E8.60407@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/01/2016 02:57 AM, Krzysztof Kozlowski wrote:
> Fix following DTC warnings in Exynos4x12 boards:
> 
> Warning (unit_address_vs_reg): Node /camera/fimc-is at 12000000/pmu has a reg or ranges property, but no unit name
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4x12.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index 84a23f962946..b7490ea0c75c 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -179,7 +179,7 @@
>  			ranges;
>  			status = "disabled";
>  
> -			pmu {
> +			pmu at 10020000 {
>  				reg = <0x10020000 0x3000>;
>  			};
>  
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
