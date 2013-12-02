From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 02 Dec 2013 17:12:45 +0100
Subject: [PATCH] ARM: at91: add uart aliases to sama5d3 dtsi
In-Reply-To: <1386000604-20829-1-git-send-email-nicolas.ferre@atmel.com>
References: <1386000604-20829-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <529CB17D.5090102@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2013 17:10, Nicolas Ferre wrote:

Acked-by Boris BREZILLON <b.brezillon@overkiz.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>   arch/arm/boot/dts/sama5d3_uart.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sama5d3_uart.dtsi b/arch/arm/boot/dts/sama5d3_uart.dtsi
> index 49d4d76ca6f4..a9fa75e41652 100644
> --- a/arch/arm/boot/dts/sama5d3_uart.dtsi
> +++ b/arch/arm/boot/dts/sama5d3_uart.dtsi
> @@ -12,6 +12,11 @@
>   #include <dt-bindings/clk/at91.h>
>   
>   / {
> +	aliases {
> +		serial5 = &uart0;
> +		serial6 = &uart1;
> +	};
> +
>   	ahb {
>   		apb {
>   			pinctrl at fffff200 {
