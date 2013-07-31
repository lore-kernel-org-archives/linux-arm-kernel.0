From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 01 Aug 2013 00:21:08 +0400
Subject: [PATCH 1/10] ARM: dts: mxs: move 'compatible' property to
 beginning of node and do some whitespace cleanups
In-Reply-To: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
References: <1375281480-25775-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <51F971B4.1050605@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/31/2013 06:37 PM, Lothar Wa?mann wrote:

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>   arch/arm/boot/dts/imx28.dtsi |    5 ++---
>   1 files changed, 2 insertions(+), 3 deletions(-)

> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 47fc5ef..0360acc 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -731,9 +731,9 @@
>   			};
>
>   			dcp at 80028000 {
> +				compatible = "fsl-dcp";

    Hm, why not the usual "fsl,dcp", where "fsl" is Freescale's stock ticker?

>   				reg = <0x80028000 0x2000>;
>   				interrupts = <52 53 54>;
> -				compatible = "fsl-dcp";
>   			};

WBR, Sergei
