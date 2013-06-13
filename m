From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 13 Jun 2013 21:14:59 +0900
Subject: [PATCH RESEND V2] ARM: dts: Correct the base address of pinctrl_3
 on Exynos5250
In-Reply-To: <1371025425-480-1-git-send-email-padma.v@samsung.com>
References: <1371025425-480-1-git-send-email-padma.v@samsung.com>
Message-ID: <150d01ce682f$a007f230$e017d690$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi Venna wrote:
> 
> This patch corrects the base address of pinctrl_3 on Exynos5250
> platform.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
> Changes since V1:
> 	- Added platform name in the subject line.
> 
>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi |    2 +-
>  arch/arm/boot/dts/exynos5250.dtsi         |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> index d1650fb..ded558b 100644
> --- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> @@ -763,7 +763,7 @@
>  		};
>  	};
> 
> -	pinctrl at 03680000 {
> +	pinctrl at 03860000 {
>  		gpz: gpz {
>  			gpio-controller;
>  			#gpio-cells = <2>;
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index 7154e3d..e9bfd13 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -169,9 +169,9 @@
>  		interrupts = <0 50 0>;
>  	};
> 
> -	pinctrl_3: pinctrl at 03680000 {
> +	pinctrl_3: pinctrl at 03860000 {
>  		compatible = "samsung,exynos5250-pinctrl";
> -		reg = <0x0368000 0x1000>;
> +		reg = <0x03860000 0x1000>;
>  		interrupts = <0 47 0>;
>  	};
> 
> --
> 1.7.4.4

Yes, right.

Thanks, applied.

- Kukjin
