From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 17 Oct 2013 18:03:17 +0200
Subject: [PATCH v4 10/17] clk: at91: add peripheral clk macros for
 peripheral clk dt bindings
In-Reply-To: <1381485180-13796-1-git-send-email-b.brezillon@overkiz.com>
References: <1381477081-6041-1-git-send-email-b.brezillon@overkiz.com>
 <1381485180-13796-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <52600A45.6070508@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2013 11:53, Boris BREZILLON :
> This patch adds the peripheral divisors macros (for sam9x5 compatible IPs)
> which will be used by peripheral clk dt definitions.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>   include/dt-bindings/clk/at91.h |    6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
> index 0b4cb99..a3b07ca 100644
> --- a/include/dt-bindings/clk/at91.h
> +++ b/include/dt-bindings/clk/at91.h
> @@ -19,4 +19,10 @@
>   #define AT91_PMC_MOSCRCS	17		/* Main On-Chip RC */
>   #define AT91_PMC_CFDEV		18		/* Clock Failure Detector Event */
>
> +/* sam9x5 peripheral divisors */
> +#define AT91SAM9X5_PERIPH_CLK_DIV1	0
> +#define AT91SAM9X5_PERIPH_CLK_DIV2	1
> +#define AT91SAM9X5_PERIPH_CLK_DIV4	2
> +#define AT91SAM9X5_PERIPH_CLK_DIV8	3
> +
>   #endif
>


-- 
Nicolas Ferre
