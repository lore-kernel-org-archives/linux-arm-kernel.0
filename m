From: sleep_walker@suse.cz (=?utf-8?q?Tom=C3=A1=C5=A1_=27Sleep=5FWalker=27?=
	=?utf-8?q?_=C4=8Cech?=)
Date: Sun, 6 Jun 2010 20:10:57 +0200
Subject: [PATCH 2/3] pxa: Fix all devices using wm97xx_batt.h
In-Reply-To: <1275613654-23918-2-git-send-email-marek.vasut@gmail.com>
References: <1275613654-23918-1-git-send-email-marek.vasut@gmail.com>
	<1275613654-23918-2-git-send-email-marek.vasut@gmail.com>
Message-ID: <201006062010.58423.sleep_walker@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne P? 4. ?ervna 2010 03:07:33 Marek Vasut napsal(a):
> This file is scheduled for removal, therefore fix all devices that use this
> file to use the suggested wm97xx.h and pass platform data properly.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  arch/arm/mach-pxa/mioa701.c  |   10 +++++++---
>  arch/arm/mach-pxa/palmld.c   |   19 ++++++++++---------
>  arch/arm/mach-pxa/palmt5.c   |   19 ++++++++++---------
>  arch/arm/mach-pxa/palmte2.c  |   20 ++++++++++++--------
>  arch/arm/mach-pxa/palmtreo.c |    1 -
>  arch/arm/mach-pxa/palmtx.c   |   19 ++++++++++---------
>  arch/arm/mach-pxa/palmz72.c  |   20 ++++++++++++--------
>  7 files changed, 61 insertions(+), 47 deletions(-)
> 
...

> diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
> index d8b4469..4eb0258 100644
> --- a/arch/arm/mach-pxa/palmtreo.c
> +++ b/arch/arm/mach-pxa/palmtreo.c
> @@ -23,7 +23,6 @@
>  #include <linux/pda_power.h>
>  #include <linux/pwm_backlight.h>
>  #include <linux/gpio.h>
> -#include <linux/wm97xx_batt.h>
>  #include <linux/power_supply.h>
>  #include <linux/sysdev.h>
>  #include <linux/w1-gpio.h>


Thanks for this one.

For palmtreo.c:

Acked-by: Tomas Cech <sleep_walker@suse.cz>

Best regards,

Tomas Cech
