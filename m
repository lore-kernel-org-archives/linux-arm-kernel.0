From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 22 Jan 2011 20:46:21 +0100
Subject: [PATCH] ARM: mach-imx/mach-mx25_3ds: Fix section type
In-Reply-To: <1295720336-28304-1-git-send-email-festevam@gmail.com>
References: <1295720336-28304-1-git-send-email-festevam@gmail.com>
Message-ID: <20110122194621.GW14956@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 22, 2011 at 04:18:56PM -0200, Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> ---
>  arch/arm/mach-imx/mach-mx25_3ds.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx25_3ds.c b/arch/arm/mach-imx/mach-mx25_3ds.c
> index aa76cfd..8382e79 100644
> --- a/arch/arm/mach-imx/mach-mx25_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx25_3ds.c
> @@ -180,7 +180,7 @@ static const uint32_t mx25pdk_keymap[] = {
>  	KEY(3, 3, KEY_POWER),
>  };
>  
> -static const struct matrix_keymap_data mx25pdk_keymap_data __initdata = {
> +static const struct matrix_keymap_data mx25pdk_keymap_data __initconst = {
>  	.keymap		= mx25pdk_keymap,
>  	.keymap_size	= ARRAY_SIZE(mx25pdk_keymap),
>  };
> -- 
> 1.6.0.4
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
