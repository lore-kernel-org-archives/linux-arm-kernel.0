From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 28 Sep 2010 14:43:16 +0400
Subject: [PATCH 3/7] leds: pwm: add a new element 'name' to platform data
In-Reply-To: <1285670134-18063-4-git-send-email-arun.murthy@stericsson.com>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
	<1285670134-18063-4-git-send-email-arun.murthy@stericsson.com>
Message-ID: <4CA1C6C4.20504@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 28-09-2010 14:35, Arun Murthy wrote:

> A new element 'name' is added to pwm led platform data structure.
> This is required to identify the pwm device.

> Signed-off-by: Arun Murthy<arun.murthy@stericsson.com>
> Acked-by: Linus Walleij<linus.walleij@stericsson.com>

[...]

> diff --git a/include/linux/leds_pwm.h b/include/linux/leds_pwm.h
> index 33a0711..7a847a0 100644
> --- a/include/linux/leds_pwm.h
> +++ b/include/linux/leds_pwm.h
> @@ -16,6 +16,7 @@ struct led_pwm {
>   struct led_pwm_platform_data {
>   	int			num_leds;
>   	struct led_pwm	*leds;
> +	char *name;
>   };

    Shouldn't '*name'be aligned, at least with '*leds'?

WBR, Sergei
