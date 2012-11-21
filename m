From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 18:43:04 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: Add aliases for i2c controller for
 exynos4
In-Reply-To: <1353450428-2615-1-git-send-email-dianders@chromium.org>
References: <1353450428-2615-1-git-send-email-dianders@chromium.org>
Message-ID: <0dfb01cdc7cc$9aa39500$cfeabf00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson wrote:
> 
> This is similar to a recent commit for exynos5250 titled:
>   ARM: EXYNOS: Add aliases for i2c controller
> 
> Adding aliases will be useful to prevent warnings in a future
> change.  See:
>   i2c: s3c2410: Get the i2c bus number from alias id
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> 
> ---
>  arch/arm/boot/dts/exynos4.dtsi |   24 ++++++++++++++++--------
>  1 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi
> b/arch/arm/boot/dts/exynos4.dtsi
> index a26c3dd..824d362 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -28,6 +28,14 @@
>  		spi0 = &spi_0;
>  		spi1 = &spi_1;
>  		spi2 = &spi_2;
> +		i2c0 = &i2c_0;
> +		i2c1 = &i2c_1;
> +		i2c2 = &i2c_2;
> +		i2c3 = &i2c_3;
> +		i2c4 = &i2c_4;
> +		i2c5 = &i2c_5;
> +		i2c6 = &i2c_6;
> +		i2c7 = &i2c_7;
>  	};
> 
>  	gic:interrupt-controller at 10490000 {
> @@ -121,7 +129,7 @@
>  		status = "disabled";
>  	};
> 
> -	i2c at 13860000 {
> +	i2c_0: i2c at 13860000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "samsung,s3c2440-i2c";
> @@ -130,7 +138,7 @@
>  		status = "disabled";
>  	};
> 
> -	i2c at 13870000 {
> +	i2c_1: i2c at 13870000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "samsung,s3c2440-i2c";
> @@ -139,7 +147,7 @@
>  		status = "disabled";
>  	};
> 
> -	i2c at 13880000 {
> +	i2c_2: i2c at 13880000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "samsung,s3c2440-i2c";
> @@ -148,7 +156,7 @@
>  		status = "disabled";
>  	};
> 
> -	i2c at 13890000 {
> +	i2c_3: i2c at 13890000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "samsung,s3c2440-i2c";
> @@ -157,7 +165,7 @@
>  		status = "disabled";
>  	};
> 
> -	i2c at 138A0000 {
> +	i2c_4: i2c at 138A0000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "samsung,s3c2440-i2c";
> @@ -166,7 +174,7 @@
>  		status = "disabled";
>  	};
> 
> -	i2c at 138B0000 {
> +	i2c_5: i2c at 138B0000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "samsung,s3c2440-i2c";
> @@ -175,7 +183,7 @@
>  		status = "disabled";
>  	};
> 
> -	i2c at 138C0000 {
> +	i2c_6: i2c at 138C0000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "samsung,s3c2440-i2c";
> @@ -184,7 +192,7 @@
>  		status = "disabled";
>  	};
> 
> -	i2c at 138D0000 {
> +	i2c_7: i2c at 138D0000 {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  		compatible = "samsung,s3c2440-i2c";
> --
> 1.7.7.3

Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
