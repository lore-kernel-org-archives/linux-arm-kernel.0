From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 20:48:38 +0800
Subject: [PATCH] ARM: imx27: Fix documentation for SPLL clock
In-Reply-To: <1371977470-12720-1-git-send-email-mpa@pengutronix.de>
References: <1371977470-12720-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20130624124836.GC30747@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 23, 2013 at 10:51:10AM +0200, Markus Pargmann wrote:
> spll_gate was added with commit b7eed2076183994dbda2c19bc7fba99b65a135e3
> "ARM: imx27: add a clock gate to activate SPLL clock".
> 
> spll_gate is missing in the devicetree clock documentation for imx27. This
> patch adds it to the list of clocks in the documentation.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Applied, thanks.

Shawn

> ---
>  Documentation/devicetree/bindings/clock/imx27-clock.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/imx27-clock.txt b/Documentation/devicetree/bindings/clock/imx27-clock.txt
> index ab1a56e..7a20703 100644
> --- a/Documentation/devicetree/bindings/clock/imx27-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/imx27-clock.txt
> @@ -98,6 +98,7 @@ clocks and IDs.
>  	fpm                  83
>  	mpll_osc_sel         84
>  	mpll_sel             85
> +	spll_gate	     86
>  
>  Examples:
>  
> -- 
> 1.8.2.1
> 
