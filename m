From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Mar 2013 15:34:18 +0800
Subject: [PATCH v2 1/3] ARM: dts: imx6q: Add pinctrl for ecspi3
In-Reply-To: <1362636010-17367-2-git-send-email-xobs@kosagi.com>
References: <1362636010-17367-1-git-send-email-xobs@kosagi.com>
 <1362636010-17367-2-git-send-email-xobs@kosagi.com>
Message-ID: <20130307073415.GE5372@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 06:00:08AM +0000, Sean Cross wrote:
> Add a group of pins to allow ecspi3 to be used on imx6q.

All 3 patches look good.  But you forgot adding your sign-off.
I added the following line and applied the patches this time.

Signed-off-by: Sean Cross <xobs@kosagi.com>

Shawn

> ---
>  arch/arm/boot/dts/imx6q.dtsip |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsip b/arch/arm/boot/dts/imx6q.dtsip
> index 749c5c4..f318678 100644
> --- a/arch/arm/boot/dts/imx6q.dtsip
> +++ b/arch/arm/boot/dts/imx6q.dtsip
> @@ -97,6 +97,16 @@
>  					};
>  				};
>  
> +				ecspi3 {
> +					pinctrl_ecspi3_1: ecspi3grp-1 {
> +						fsl,pins = <
> +							MX6Q_PAD_DISP0_DAT2__ECSPI3_MISO 0x100b1
> +							MX6Q_PAD_DISP0_DAT1__ECSPI3_MOSI 0x100b1
> +							MX6Q_PAD_DISP0_DAT0__ECSPI3_SCLK 0x100b1
> +						>;
> +					};
> +				};
> +
>  				enet {
>  					pinctrl_enet_1: enetgrp-1 {
>  						fsl,pins = <
> -- 
> 1.7.9.5
> 
