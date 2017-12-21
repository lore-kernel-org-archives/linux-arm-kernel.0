From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 21 Dec 2017 09:54:09 +0900
Subject: [PATCH 2/2] arm64: dts: exynos: Fix typo in MSCL clock
 controller unit address
In-Reply-To: <20171220192702.32515-2-krzk@kernel.org>
References: <20171220192702.32515-1-krzk@kernel.org>
 <CGME20171220192745epcas3p48bae7a4f6711433752beb01c5811e1af@epcas3p4.samsung.com>
 <20171220192702.32515-2-krzk@kernel.org>
Message-ID: <5A3B0631.6090305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017? 12? 21? 04:27, Krzysztof Kozlowski wrote:
> Fix typo in unit address of MSCL clock controller (the reg entry is
> correct).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 0ba5df825eff..3e8311c60d1b 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -468,7 +468,7 @@
>  			clocks = <&xxti>, <&cmu_mif CLK_SCLK_BUS_PLL_ATLAS>;
>  		};
>  
> -		cmu_mscl: clock-controller at 105d0000 {
> +		cmu_mscl: clock-controller at 150d0000 {
>  			compatible = "samsung,exynos5433-cmu-mscl";
>  			reg = <0x150d0000 0x1000>;
>  			#clock-cells = <1>;
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
