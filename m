From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jun 2012 09:17:39 +0800
Subject: [PATCH] ARM: imx23-evk.dts: Fix total RAM size
In-Reply-To: <1340046070-1955-1-git-send-email-fabio.estevam@freescale.com>
References: <1340046070-1955-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120619011737.GI19249@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 04:01:10PM -0300, Fabio Estevam wrote:
> mx23evk has 64MB of RAM, so fix the RAM size accordingly.
> 
Are you sure about that?  Please check hardware document again.

Regards,
Shawn

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx23-evk.dts |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
> index 70bffa9..00390fb 100644
> --- a/arch/arm/boot/dts/imx23-evk.dts
> +++ b/arch/arm/boot/dts/imx23-evk.dts
> @@ -17,7 +17,7 @@
>  	compatible = "fsl,imx23-evk", "fsl,imx23";
>  
>  	memory {
> -		reg = <0x40000000 0x08000000>;
> +		reg = <0x40000000 0x04000000>;
>  	};
>  
>  	apb at 80000000 {
> -- 
> 1.7.1
> 
> 
