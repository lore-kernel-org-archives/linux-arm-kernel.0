From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 02 Dec 2013 13:55:55 +0100
Subject: [PATCH v2] ARM: at91: add usart3 alias to dtsi
In-Reply-To: <1385988793-1787-1-git-send-email-nicolas.ferre@atmel.com>
References: <1385979186-29447-1-git-send-email-nicolas.ferre@atmel.com>
 <1385988793-1787-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <529C835B.7050908@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2013 13:53, Nicolas Ferre wrote:
> Alias was missing for SoC of the at91sam9x5 familly that embed USART3.
Acked-by: Boris BREZILLON <b.brezillon@overkiz.com>
>
> Reported-by: Jiri Prchal <jiri.prchal@aksignal.cz>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Boris Brezillon <b.brezillon@overkiz.com>
> ---
>   arch/arm/boot/dts/at91sam9x5_usart3.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
> index 2347e9563cef..6801106fa1f8 100644
> --- a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
> @@ -11,6 +11,10 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   
>   / {
> +	aliases {
> +		serial4 = &usart3;
> +	};
> +
>   	ahb {
>   		apb {
>   			pinctrl at fffff400 {
