From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 21 Jun 2013 13:48:51 +0800
Subject: [PATCH v2 1/3] ARM: dts: imx6dl: add a new pinctrl for ecspi1
In-Reply-To: <1371781151-20749-1-git-send-email-b32955@freescale.com>
References: <1371781151-20749-1-git-send-email-b32955@freescale.com>
Message-ID: <20130621054849.GC25633@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 10:19:09AM +0800, Huang Shijie wrote:
> This new pinctrl is used in the imx6dl-sabresd board.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Applied all 3, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx6dl.dtsi |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index 2b3ecd6..d961365 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -56,6 +56,14 @@
>  							MX6DL_PAD_EIM_D16__ECSPI1_SCLK 0x100b1
>  						>;
>  					};
> +
> +					pinctrl_ecspi1_2: ecspi1grp-2 {
> +						fsl,pins = <
> +							MX6DL_PAD_KEY_COL1__ECSPI1_MISO 0x100b1
> +							MX6DL_PAD_KEY_ROW0__ECSPI1_MOSI 0x100b1
> +							MX6DL_PAD_KEY_COL0__ECSPI1_SCLK 0x100b1
> +						>;
> +					};
>  				};
>  
>  				enet {
> -- 
> 1.7.1
> 
> 
