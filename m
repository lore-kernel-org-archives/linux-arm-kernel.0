From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 9 Oct 2013 15:12:20 +0200
Subject: [PATCH 4/6] ARM: at91/dt: define sama5d3xek's main clk frequency
In-Reply-To: <1375954563-11343-1-git-send-email-b.brezillon@overkiz.com>
References: <1375951572-10829-1-git-send-email-b.brezillon@overkiz.com>
 <1375954563-11343-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52555634.7020500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2013 11:36, Boris BREZILLON :
> Define the main clock frequency for the new main clock node
> in sama5d3xcm.dtsi.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>   arch/arm/boot/dts/sama5d3xcm.dtsi |    6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
> index 6a1871b..f19d5bf 100644
> --- a/arch/arm/boot/dts/sama5d3xcm.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
> @@ -38,6 +38,12 @@
>   			macb0: ethernet at f0028000 {
>   				phy-mode = "rgmii";
>   			};
> +
> +			pmc: pmc at fffffc00 {
> +				main: mainck {
> +					clock-frequency = <12000000>;
> +				};
> +			};
>   		};
>
>   		nand0: nand at 60000000 {
>


-- 
Nicolas Ferre
