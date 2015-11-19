From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Nov 2015 20:17:37 +0100
Subject: [PATCH 3/3] leds/pwm: fix driver description and make license
 match the header
In-Reply-To: <1385412225-29740-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1385412225-29740-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1385412225-29740-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20151119191737.GF22022@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

while the other two patches in this thread are controversal, this one
shouldn't. It still sits in my branch with unapplied patches since
nearly two years, which is enormous considering it's such an easy patch.

Best regards
Uwe

On Mon, Nov 25, 2013 at 09:43:45PM +0100, Uwe Kleine-K?nig wrote:
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/leds/leds-pwm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
> index cdc3e4d..0796ca3 100644
> --- a/drivers/leds/leds-pwm.c
> +++ b/drivers/leds/leds-pwm.c
> @@ -239,6 +239,6 @@ static struct platform_driver led_pwm_driver = {
>  module_platform_driver(led_pwm_driver);
>  
>  MODULE_AUTHOR("Luotao Fu <l.fu@pengutronix.de>");
> -MODULE_DESCRIPTION("PWM LED driver for PXA");
> -MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("generic PWM LED driver");
> +MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:leds-pwm");
> -- 
> 1.8.4.2
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
