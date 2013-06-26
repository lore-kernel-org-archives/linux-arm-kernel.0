From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 26 Jun 2013 21:59:21 +0800
Subject: [PATCH 03/16] ARM: dts: i.MX6qdl: Add i.MX31 compatible to gpt
 node
In-Reply-To: <1372168320-22605-4-git-send-email-s.hauer@pengutronix.de>
References: <1372168320-22605-1-git-send-email-s.hauer@pengutronix.de>
 <1372168320-22605-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20130626135920.GB21845@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 03:51:47PM +0200, Sascha Hauer wrote:
> The i.MX6 gpt is handled by the i.MX31 gpt driver in the kernel,

Just out of curiosity, where is the gpt driver you are talking about?

Shawn

> so add a corresponding compatible entry.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 9efaa56..7707f2e 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -294,7 +294,7 @@
>  			};
>  
>  			gpt: gpt at 02098000 {
> -				compatible = "fsl,imx6q-gpt";
> +				compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
>  				reg = <0x02098000 0x4000>;
>  				interrupts = <0 55 0x04>;
>  				clocks = <&clks 119>, <&clks 120>;
> -- 
> 1.8.3.1
> 
