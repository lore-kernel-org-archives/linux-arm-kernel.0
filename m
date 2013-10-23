From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 23 Oct 2013 16:23:26 +0800
Subject: [PATCH 2/4] ARM: dts: add Gateworks Ventana support
In-Reply-To: <1382503888-3962-3-git-send-email-tharvey@gateworks.com>
References: <1382503888-3962-1-git-send-email-tharvey@gateworks.com>
 <1382503888-3962-3-git-send-email-tharvey@gateworks.com>
Message-ID: <20131023082324.GO2839@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 22, 2013 at 09:51:26PM -0700, Tim Harvey wrote:
> The Gateworks Ventana product family consists of several baseboard designs
> based on the Freescale i.MX6 family of processors.  Each baseboard has a
> different set of possible features.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---

<snip>

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 3043e6c..2b7084c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -131,10 +131,19 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx53-mba53.dtb \
>  	imx53-qsb.dtb \
>  	imx53-smd.dtb \
> +	imx6dl-gw54xx.dtb \
> +	imx6dl-gw53xx.dtb \
> +	imx6dl-gw52xx.dtb \
> +	imx6dl-gw51xx.dtb \

Sorted it like 51xx, 52xx, 53xx, 54xx, and applied the patch.  Thanks.

Shawn

>  	imx6dl-sabreauto.dtb \
>  	imx6dl-sabresd.dtb \
>  	imx6dl-wandboard.dtb \
>  	imx6q-arm2.dtb \
> +	imx6q-gw5400-a.dtb \
> +	imx6q-gw54xx.dtb \
> +	imx6q-gw53xx.dtb \
> +	imx6q-gw52xx.dtb \
> +	imx6q-gw51xx.dtb \
>  	imx6q-phytec-pbab01.dtb \
>  	imx6q-sabreauto.dtb \
>  	imx6q-sabrelite.dtb \
