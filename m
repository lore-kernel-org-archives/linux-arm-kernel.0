From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Wed, 05 Jul 2017 11:25:47 +0900
Subject: [PATCH] arm64: dts: exynos: remove num-slots from exynos platforms
In-Reply-To: <1499159859-67028-1-git-send-email-shawn.lin@rock-chips.com>
References: <CGME20170704091754epcas2p4d4f5717b2cd00570521f68b5f2e10237@epcas2p4.samsung.com>
 <1499159859-67028-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <07f63741-3a00-003a-6176-8752bf93ec2a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2017 06:17 PM, Shawn Lin wrote:
> dwmmc driver deprecated num-slots and plan to get rid
> of it finally. Just move a step to cleanup it from DT.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
> 
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 --
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts       | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index e2b0da2..7f693ae 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -846,7 +846,6 @@
>  
>  &mshc_0 {
>  	status = "okay";
> -	num-slots = <1>;
>  	mmc-hs200-1_8v;
>  	mmc-hs400-1_8v;
>  	cap-mmc-highspeed;
> @@ -868,7 +867,6 @@
>  
>  &mshc_2 {
>  	status = "okay";
> -	num-slots = <1>;
>  	cap-sd-highspeed;
>  	disable-wp;
>  	cd-gpios = <&gpa2 4 GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index e5892bb..4a8b1fb 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -359,7 +359,6 @@
>  
>  &mmc_0 {
>  	status = "okay";
> -	num-slots = <1>;
>  	cap-mmc-highspeed;
>  	mmc-hs200-1_8v;
>  	non-removable;
> @@ -375,7 +374,6 @@
>  
>  &mmc_2 {
>  	status = "okay";
> -	num-slots = <1>;
>  	cap-sd-highspeed;
>  	card-detect-delay = <200>;
>  	clock-frequency = <400000000>;
> 
