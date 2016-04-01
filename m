From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 1 Apr 2016 13:30:21 -0400
Subject: [PATCH 09/11] ARM: dts: exynos: Fix DTC unit name warnings in
 SMDK5420
In-Reply-To: <1459493874-2366-9-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <1459493874-2366-9-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56FEB02D.2050001@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 04/01/2016 02:57 AM, Krzysztof Kozlowski wrote:
> Fix following DTC warnings in Exynos5420 SMDK5420:
> 
> Warning (unit_address_vs_reg): Node /dp-controller at 145B0000/display-timings/timing at 0 has a unit name, but no reg property
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-smdk5420.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> index 0785fedf441e..99160f796851 100644
> --- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
> +++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
> @@ -111,7 +111,7 @@
>  
>  	display-timings {
>  		native-mode = <&timing0>;
> -		timing0: timing at 0 {
> +		timing0: timing {
>  			clock-frequency = <50000>;
>  			hactive = <2560>;
>  			vactive = <1600>;
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
