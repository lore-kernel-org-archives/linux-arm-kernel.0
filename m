From: smoch@web.de (Soeren Moch)
Date: Thu, 06 Nov 2014 17:13:31 +0100
Subject: [PATCH] ARM: dts: imx6q-tbs2910: Remove unneeded 'fsl,
 mode' property
In-Reply-To: <1415189571-24035-1-git-send-email-festevam@gmail.com>
References: <1415189571-24035-1-git-send-email-festevam@gmail.com>
Message-ID: <545B9E2B.2000605@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/14 13:12, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> imx6q-tbs2910 board uses sgtl5000 codec and the machine file (imx-sgtl5000)
> already sets SSI in slave mode and codec in master mode, so there is no need
> for having this property.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>


Yes, audio still works without that property.

Tested-by: Soeren Moch <smoch@web.de>


> ---
>   arch/arm/boot/dts/imx6q-tbs2910.dts | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
> index d2a5743..f7427bf 100644
> --- a/arch/arm/boot/dts/imx6q-tbs2910.dts
> +++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
> @@ -215,7 +215,6 @@
>   };
>
>   &ssi1 {
> -	fsl,mode = "i2s-slave";
>   	status = "okay";
>   };
>
>
