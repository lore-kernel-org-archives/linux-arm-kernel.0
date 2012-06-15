From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Jun 2012 09:14:16 +0200
Subject: [PATCH] ARM: imx27/dt: make dt_compat entry const
In-Reply-To: <1339149890-18973-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1339149890-18973-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120615071416.GW30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2012 at 12:04:50PM +0200, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-imx/imx27-dt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

Sascha

> 
> diff --git a/arch/arm/mach-imx/imx27-dt.c b/arch/arm/mach-imx/imx27-dt.c
> index ed38d03..779e539 100644
> --- a/arch/arm/mach-imx/imx27-dt.c
> +++ b/arch/arm/mach-imx/imx27-dt.c
> @@ -74,7 +74,7 @@ static struct sys_timer imx27_timer = {
>  	.init = imx27_timer_init,
>  };
>  
> -static const char *imx27_dt_board_compat[] __initdata = {
> +static const char * const imx27_dt_board_compat[] __initconst = {
>  	"fsl,imx27",
>  	NULL
>  };
> -- 
> 1.7.10
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
