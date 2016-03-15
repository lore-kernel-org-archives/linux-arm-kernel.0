From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Tue, 15 Mar 2016 12:53:03 +0200
Subject: [PATCH 6/9] ARM: dts: imx: add Boundary Devices Nitrogen6_SoloX
 board
In-Reply-To: <1458037826-19375-7-git-send-email-gary.bisson@boundarydevices.com>
References: <1458037826-19375-1-git-send-email-gary.bisson@boundarydevices.com>
 <1458037826-19375-7-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <56E7E98F.5030902@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.03.2016 12:30, Gary Bisson wrote:
> Based on i.MX6 SoloX with 1GB of RAM.
> 
> https://boundarydevices.com/product/nit6_solox-imx6/
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
>  arch/arm/boot/dts/Makefile               |   1 +
>  arch/arm/boot/dts/imx6sx-nitrogen6sx.dts | 745 +++++++++++++++++++++++++++++++
>  2 files changed, 746 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 279ec61..6a2bbc4 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -363,6 +363,7 @@ dtb-$(CONFIG_SOC_IMX6SL) += \
>  	imx6sl-evk.dtb \
>  	imx6sl-warp.dtb
>  dtb-$(CONFIG_SOC_IMX6SX) += \
> +	imx6sx-nitrogen6sx.dtb \
>  	imx6sx-sabreauto.dtb \
>  	imx6sx-sdb-reva.dtb \
>  	imx6sx-sdb.dtb
> diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
> new file mode 100644
> index 0000000..8440890
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
> @@ -0,0 +1,745 @@

[snip]

> +
> +//&clks {
> +//	assigned-clocks = <&clks IMX6SX_PLL4_BYPASS_SRC>,
> +//			  <&clks IMX6SX_PLL4_BYPASS>,
> +//			  <&clks IMX6SX_CLK_CKO>,
> +//			  <&clks IMX6SX_CLK_CKO1_SEL>,
> +//			  <&clks IMX6SX_CLK_PLL4_POST_DIV>;
> +//	assigned-clock-parents = <&clks IMX6SX_CLK_LVDS2_IN>,
> +//				 <&clks IMX6SX_PLL4_BYPASS_SRC>,
> +//				 <&clks IMX6SX_CLK_CKO1>,
> +//				 <&clks IMX6SX_CLK_CKIL>;
> +//	assigned-clock-rates = <0>, <0>, <0>, <0>, <24576000>;
> +//};

What does // do above?

--
With best wishes,
Vladimir
