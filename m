From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 14 Jul 2015 15:25:38 +0800
Subject: [PATCH][v2] ARM: ls1021a: dtsi: Add crypto node alias in device
 tree
In-Reply-To: <1436847195-12523-1-git-send-email-ruchika.gupta@freescale.com>
References: <1436847195-12523-1-git-send-email-ruchika.gupta@freescale.com>
Message-ID: <20150714072538.GI4119@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 09:43:15AM +0530, Ruchika Gupta wrote:
> U-boot patches up the device tree crypto node for the era property.
> 
> Signed-off-by: Ruchika Gupta <ruchika.gupta@freescale.com>
> ---
> Changes from v1:
> Rearranged the crypto node in alphabetic sorted order as suggested by Shawn 
> 
>  arch/arm/boot/dts/ls1021a.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index c70bb27..42dffae 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -53,6 +53,7 @@
>  	interrupt-parent = <&gic>;
>  
>  	aliases {
> +		crypto = &crypto;

Wait.  Did miss any prerequisite patch?  I do not have the label in my
tree.

  DTC     arch/arm/boot/dts/ls1021a-qds.dtb
ERROR (path_references): Reference to non-existent node or label "crypto"

Patch dropped.

Shawn

>  		serial0 = &lpuart0;
>  		serial1 = &lpuart1;
>  		serial2 = &lpuart2;
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
