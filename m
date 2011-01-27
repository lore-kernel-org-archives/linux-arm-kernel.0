From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 28 Jan 2011 07:00:04 +0800
Subject: [PATCH] ARM: mxs/imx28: remove now unused clock lookup "fec.0"
In-Reply-To: <1296124114-16588-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1296124114-16588-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110127230003.GA14993@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 11:28:34AM +0100, Uwe Kleine-K?nig wrote:
> Commit b2878fa (ARM: mx28: update clock and device name for dual fec
> support) added only the new lookups without removing the old one.
> 
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-mxs/clock-mx28.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
> index 865ce83..5580a21 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -609,7 +609,6 @@ static struct clk_lookup lookups[] = {
>  	_REGISTER_CLOCK("duart", NULL, uart_clk)
>  	_REGISTER_CLOCK("imx28-fec.0", NULL, fec_clk)
>  	_REGISTER_CLOCK("imx28-fec.1", NULL, fec_clk)
> -	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
>  	_REGISTER_CLOCK("mxs-auart.0", NULL, uart_clk)
>  	_REGISTER_CLOCK("mxs-auart.1", NULL, uart_clk)
>  	_REGISTER_CLOCK("mxs-auart.2", NULL, uart_clk)
> -- 
> 1.7.2.3
> 

Acked-by: Shawn Guo <shawn.guo@freescale.com>
