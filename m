From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 30 Dec 2015 19:16:09 +0100
Subject: [PATCH 15/69] clocksource/drivers/mediatek: Add the COMPILE_TEST
 option
In-Reply-To: <1450448302-27429-15-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
 <1450448302-27429-15-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <56841F69.9010303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/12/15 15:17, Daniel Lezcano wrote:
> Increase the compilation test coverage by adding the COMPILE_TEST option.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

>   drivers/clocksource/Kconfig | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 96a34dc..3ba43f6 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -228,9 +228,11 @@ config SYS_SUPPORTS_SH_CMT
>           bool
>
>   config MTK_TIMER
> +	bool "Mediatek timer driver" if COMPILE_TEST
>   	select CLKSRC_OF
>   	select CLKSRC_MMIO
> -	bool
> +	help
> +	  Support for Mediatek timer driver.
>
>   config SYS_SUPPORTS_SH_MTU2
>           bool
>
