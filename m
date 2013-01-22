From: jic23@kernel.org (Jonathan Cameron)
Date: Tue, 22 Jan 2013 12:06:43 +0000
Subject: [PATCH 2/2] ARM: mxs: Add OF props for MX23 LRADC
In-Reply-To: <1358798722-25102-2-git-send-email-marex@denx.de>
References: <1358798722-25102-1-git-send-email-marex@denx.de>
 <1358798722-25102-2-git-send-email-marex@denx.de>
Message-ID: <50FE80D3.1020104@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 08:05 PM, Marek Vasut wrote:
> Add interrupt mapping and compatible string for MX23 LRADC.

Series looks fine to me, but obviously I'd like an ACK for this one
from Shawn before taking it.

Thanks,

Jonathan

> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx23.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 65415c5..56afcf4 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -391,7 +391,9 @@
>  			};
>  
>  			lradc at 80050000 {
> +				compatible = "fsl,imx23-lradc";
>  				reg = <0x80050000 0x2000>;
> +				interrupts = <36 37 38 39 40 41 42 43 44>;
>  				status = "disabled";
>  			};
>  
> 
