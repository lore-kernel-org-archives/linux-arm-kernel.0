From: marex@denx.de (Marek Vasut)
Date: Sun, 28 Oct 2012 23:01:04 +0100
Subject: [PATCH 4/5] ARM: PXA: Zipit Z2: Change active_state of power
 button
In-Reply-To: <1351438555-4668-4-git-send-email-anarsoul@gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-4-git-send-email-anarsoul@gmail.com>
Message-ID: <201210282301.04714.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Vasily Khoruzhick,

> From: mcmajeres <mark@engine12.com>

Read [1]

> Otherwise userspace might be confused about button state
> 
> Signed-off-by: mcmajeres <mark@engine12.com>

Attribution of code shall be done only towards people known by their name.

> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm/mach-pxa/z2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
> index ce90fa9..fac7cba 100644
> --- a/arch/arm/mach-pxa/z2.c
> +++ b/arch/arm/mach-pxa/z2.c
> @@ -437,7 +437,7 @@ static struct gpio_keys_button z2_pxa_buttons[] = {
>  	{
>  		.code		= KEY_POWER,
>  		.gpio		= GPIO1_ZIPITZ2_POWER_BUTTON,
> -		.active_low	= 0,
> +		.active_low	= 1,
>  		.desc		= "Power Button",
>  		.wakeup		= 1,
>  		.type		= EV_KEY,

[1] http://lwn.net/Articles/195643/

Best regards,
Marek Vasut
