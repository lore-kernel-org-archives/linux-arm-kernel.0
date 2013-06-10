From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 10 Jun 2013 17:24:55 +0900
Subject: [PATCH] ARM: dts: add vmmc regulator support for ODROID-X
In-Reply-To: <1370454336-13003-1-git-send-email-tobetter@gmail.com>
References: <1370454336-13003-1-git-send-email-tobetter@gmail.com>
Message-ID: <0e9e01ce65b3$fcc3ba00$f64b2e00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dongjin Kim wrote:
> 
> This patch is to add vmmc regulator node at MSHC and SDHCI for ODROID-X
> board file.
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroidx.dts |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
> index 1786225..3f3d7c8 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidx.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
> @@ -44,6 +44,7 @@
>  		pinctrl-0 = <&sd4_clk &sd4_cmd &sd4_bus4 &sd4_bus8>;
>  		pinctrl-names = "default";
>  		status = "okay";
> +		vmmc-supply = <&ldo20_reg &buck8_reg>;
> 
>  		num-slots = <1>;
>  		supports-highspeed;
> @@ -78,6 +79,7 @@
>  		bus-width = <4>;
>  		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>  		pinctrl-names = "default";
> +		vmmc-supply = <&ldo4_reg &ldo21_reg>;
>  		status = "okay";
>  	};
> 
> --
> 1.7.9.5

Applied, thanks.

- Kukjin
