From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Feb 2010 10:16:34 +0100
Subject: [PATCH 3/3] gpiolib: document that names can contain printk
	format specifiers
In-Reply-To: <1265620180-14150-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100203155558.GH11354@pengutronix.de>
	<1265620180-14150-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20100208091634.GD15255@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Feb 08, 2010 at 10:09:40AM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  include/asm-generic/gpio.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index 37af893..abdb5d3 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -60,7 +60,8 @@ struct module;
>   * @names: if set, must be an array of strings to use as alternative
>   *      names for the GPIOs in this chip. Any entry in the array
>   *      may be NULL if there is no alias for the GPIO, however the
> - *      array must be @ngpio entries long.
> + *      array must be @ngpio entries long.  A name can include a single printk
> + *      format specifier for an unsigned int.
probably add: "It is substituted by the actual number of the gpio."

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
