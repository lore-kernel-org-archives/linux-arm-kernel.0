From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 13 Jul 2015 23:11:37 +0800
Subject: [PATCH] ARM: ls1021a: dtsi: Add crypto node alias in device tree
In-Reply-To: <1435918622-19121-1-git-send-email-ruchika.gupta@freescale.com>
References: <1435918622-19121-1-git-send-email-ruchika.gupta@freescale.com>
Message-ID: <20150713151137.GB26642@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 03, 2015 at 03:47:02PM +0530, Ruchika Gupta wrote:
> U-boot patches up the device tree crypto node for the era property.
> 
> Signed-off-by: Ruchika Gupta <ruchika.gupta@freescale.com>
> ---
>  arch/arm/boot/dts/ls1021a.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index c70bb27..1a99724 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -60,6 +60,7 @@
>  		serial4 = &lpuart4;
>  		serial5 = &lpuart5;
>  		sysclk = &sysclk;
> +		crypto = &crypto;

Please keep the list alphabetically sorted.

Shawn

>  	};
>  
>  	cpus {
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
