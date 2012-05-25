From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 25 May 2012 10:50:58 +0800
Subject: [PATCH 4/5] ARM: imx6q: add DT node for gpmi-nand
In-Reply-To: <1337856659-24812-4-git-send-email-b32955@freescale.com>
References: <1337856659-24812-1-git-send-email-b32955@freescale.com>
 <1337856659-24812-4-git-send-email-b32955@freescale.com>
Message-ID: <20120525025055.GE3332@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 06:50:58PM +0800, Huang Shijie wrote:
> Add DT node for gpmi-nand.
> Also enable the gpmi-nand for mx6q-arm2 board.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-arm2.dts |    4 ++++
>  arch/arm/boot/dts/imx6q.dtsi     |   12 ++++++++++++
>  2 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
> index db4c609..15f9e0b 100644
> --- a/arch/arm/boot/dts/imx6q-arm2.dts
> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
> @@ -22,6 +22,10 @@
>  	};
>  
>  	soc {
> +		gpmi-nand at 00112000 {

Missing pinctrl setup?

> +			status = "okay";
> +		};
> +

-- 
Regards,
Shawn
