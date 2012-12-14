From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Dec 2012 14:51:01 -0800
Subject: [PATCH] ARM: dts: Add build target for omap4-panda-a4
In-Reply-To: <1355522139-8241-1-git-send-email-jon-hunter@ti.com>
References: <1355522139-8241-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20121214225100.GP4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [121214 13:58]:
> Commit 0d9250c (ARM: dts: omap4-panda: Add pinmux configuration for
> HDMI) added a new device-tree source file for Rev A4 of the OMAP4430
> Panda board but it did not add this version to the makefile. Hence,
> add this file to the makefile.

Thanks applying into omap-for-v3.8/fixes-for-merge-window.

Tony
 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/Makefile |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 2af359c..f8b4ff4 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -105,6 +105,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>  	omap3-evm.dtb \
>  	omap3-tobi.dtb \
>  	omap4-panda.dtb \
> +	omap4-panda-a4.dtb \
>  	omap4-panda-es.dtb \
>  	omap4-var-som.dtb \
>  	omap4-sdp.dtb \
> -- 
> 1.7.10.4
> 
