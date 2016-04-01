From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 1 Apr 2016 10:27:20 -0400
Subject: [PATCH 02/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Exynos3250
In-Reply-To: <1459493874-2366-2-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <1459493874-2366-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56FE8548.5060501@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/01/2016 02:57 AM, Krzysztof Kozlowski wrote:
> Fix following DTC warnings in Exynos3250 boards:
> 
> Warning (unit_address_vs_reg): Node /soc/video-phy at 10020710 has a unit name, but no reg property
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index 137f9015d4e8..5225e953d2ed 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -153,7 +153,7 @@
>  			interrupt-parent = <&gic>;
>  		};
>  
> -		mipi_phy: video-phy at 10020710 {
> +		mipi_phy: video-phy {
>  			compatible = "samsung,s5pv210-mipi-video-phy";
>  			#phy-cells = <1>;
>  			syscon = <&pmu_system_controller>;
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
