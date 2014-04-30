From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 30 Apr 2014 14:37:46 +0800
Subject: [PATCH 1/3] arm: dts: imx6qdl, remove fsl,ssi-dma-events
In-Reply-To: <1398694356-22511-2-git-send-email-mpa@pengutronix.de>
References: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
 <1398694356-22511-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20140430063740.GD16727@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 04:12:34PM +0200, Markus Pargmann wrote:
> All dtsi files where already moved to generic dma bindings. Remove the
> old non-generic DMA properties.

Yea, since we're not required to boot old kernel with new DTB, we can
drop it.  But can I ask you to clean it up globally for IMX dts files.

Shawn

> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 947e463..b230c09 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -261,7 +261,6 @@
>  					       <&sdma 38 1 0>;
>  					dma-names = "rx", "tx";
>  					fsl,fifo-depth = <15>;
> -					fsl,ssi-dma-events = <38 37>;
>  					status = "disabled";
>  				};
>  
> @@ -276,7 +275,6 @@
>  					       <&sdma 42 1 0>;
>  					dma-names = "rx", "tx";
>  					fsl,fifo-depth = <15>;
> -					fsl,ssi-dma-events = <42 41>;
>  					status = "disabled";
>  				};
>  
> @@ -291,7 +289,6 @@
>  					       <&sdma 46 1 0>;
>  					dma-names = "rx", "tx";
>  					fsl,fifo-depth = <15>;
> -					fsl,ssi-dma-events = <46 45>;
>  					status = "disabled";
>  				};
>  
> -- 
> 1.9.1
> 
