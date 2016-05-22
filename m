From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 22 May 2016 22:16:15 +0200
Subject: [PATCH 0096/1529] Fix typo
In-Reply-To: <20160521114912.4331-1-andrea.gelmini@gelma.net>
References: <20160521114912.4331-1-andrea.gelmini@gelma.net>
Message-ID: <20160522201615.GD23704@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrea,

On Sat, May 21, 2016 at 01:49:12PM +0200, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  arch/arm/mach-imx/hardware.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
> index d737f95..026441c 100644
> --- a/arch/arm/mach-imx/hardware.h
> +++ b/arch/arm/mach-imx/hardware.h
> @@ -121,7 +121,7 @@
>  	.type = _type,							\
>  }
>  
> -/* There's a off-by-one betweem the gpio bank number and the gpiochip */
> +/* There's a off-by-one between the gpio bank number and the gpiochip */

maybe fix s/a/an/ in the same go? And I'd suggest to squash your patches
by directory (here: arch/arm/mach-imx or even arch/arm/mach-*) and add a
commit log that could for example mention the tool you used to find and
fix these typos.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
