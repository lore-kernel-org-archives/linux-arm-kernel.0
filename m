From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 14:36:24 +0800
Subject: [PATCH 3/3] ARM: dts: Add missing imx27-phytec-phycore dtb target
In-Reply-To: <1365348554-24345-3-git-send-email-shc_work@mail.ru>
References: <1365348554-24345-1-git-send-email-shc_work@mail.ru>
 <1365348554-24345-3-git-send-email-shc_work@mail.ru>
Message-ID: <20130408063621.GD5047@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 07:29:14PM +0400, Alexander Shiyan wrote:
> The patch adds missing imx27-phytec-phycore dtb target into Makefile.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.

> ---
>  arch/arm/boot/dts/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 35976f0..a06d9f1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -98,6 +98,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx27-apf27.dtb \
>  	imx27-apf27dev.dtb \
>  	imx27-pdk.dtb \
> +	imx27-phytec-phycore.dtb \
>  	imx31-bug.dtb \
>  	imx51-apf51.dtb \
>  	imx51-apf51dev.dtb \
> -- 
> 1.8.1.5
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
