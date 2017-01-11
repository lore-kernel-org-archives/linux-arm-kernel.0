From: robh@kernel.org (Rob Herring)
Date: Wed, 11 Jan 2017 15:15:03 -0600
Subject: [PATCH] arm64: dts: exynos: Replace small letter of base
 address/offset on Exynos5433
In-Reply-To: <1484096148-17120-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20170111005552epcas1p4a1f6ed88022b46544dec4b3801583267@epcas1p4.samsung.com>
 <1484096148-17120-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <20170111211503.6kwqaunb5mpe6eb2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 09:55:48AM +0900, Chanwoo Choi wrote:
> This patch replaces the small letter of base address, offset and hex value
> with the capital letter to keep the consistency on Exynos5433.

You mean the other way around, right?

> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index abaf6b4d599d..d7ed1a68b6fd 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -231,7 +231,7 @@
>  		compatible = "arm,psci";
>  		method = "smc";
>  		cpu_off = <0x84000002>;
> -		cpu_on = <0xC4000003>;
> +		cpu_on = <0xc4000003>;
>  	};
>  
>  	reboot: syscon-reboot {
> @@ -753,7 +753,7 @@
>  
>  		dsi: dsi at 13900000 {
>  			compatible = "samsung,exynos5433-mipi-dsi";
> -			reg = <0x13900000 0xC0>;
> +			reg = <0x13900000 0xc0>;
>  			interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
>  			phys = <&mipi_phy 1>;
>  			phy-names = "dsim";
> @@ -880,9 +880,9 @@
>  			iommus = <&sysmmu_jpeg>;
>  		};
>  
> -		mfc: codec at 152E0000 {
> +		mfc: codec at 152e0000 {
>  			compatible = "samsung,exynos5433-mfc";
> -			reg = <0x152E0000 0x10000>;
> +			reg = <0x152e0000 0x10000>;
>  			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "pclk", "aclk", "aclk_xiu";
>  			clocks = <&cmu_mfc CLK_PCLK_MFC>,
> @@ -914,7 +914,7 @@
>  
>  		sysmmu_gscl0: sysmmu at 13c80000 {
>  			compatible = "samsung,exynos-sysmmu";
> -			reg = <0x13C80000 0x1000>;
> +			reg = <0x13c80000 0x1000>;
>  			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "aclk", "pclk";
>  			clocks = <&cmu_gscl CLK_ACLK_SMMU_GSCL0>,
> @@ -924,7 +924,7 @@
>  
>  		sysmmu_gscl1: sysmmu at 13c90000 {
>  			compatible = "samsung,exynos-sysmmu";
> -			reg = <0x13C90000 0x1000>;
> +			reg = <0x13c90000 0x1000>;
>  			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "aclk", "pclk";
>  			clocks = <&cmu_gscl CLK_ACLK_SMMU_GSCL1>,
> @@ -934,7 +934,7 @@
>  
>  		sysmmu_gscl2: sysmmu at 13ca0000 {
>  			compatible = "samsung,exynos-sysmmu";
> -			reg = <0x13CA0000 0x1000>;
> +			reg = <0x13ca0000 0x1000>;
>  			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-names = "aclk", "pclk";
>  			clocks = <&cmu_gscl CLK_ACLK_SMMU_GSCL2>,
> -- 
> 1.9.1
> 
