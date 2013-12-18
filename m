From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 17 Dec 2013 16:44:13 -0800
Subject: [PATCH v12 08/08] ARM: hi3xxx: select GPIO in Kconfig
In-Reply-To: <1386748497-11290-9-git-send-email-haojian.zhuang@gmail.com>
 (Haojian Zhuang's message of "Wed, 11 Dec 2013 15:54:57 +0800")
References: <1386748497-11290-1-git-send-email-haojian.zhuang@gmail.com>
 <1386748497-11290-9-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <87mwjzm1ia.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> Select GPIO in hi3xxx Kconfig.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  arch/arm/mach-hi3xxx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-hi3xxx/Kconfig b/arch/arm/mach-hi3xxx/Kconfig
> index 4007ecf..018ad67 100644
> --- a/arch/arm/mach-hi3xxx/Kconfig
> +++ b/arch/arm/mach-hi3xxx/Kconfig
> @@ -3,6 +3,7 @@ config ARCH_HI3xxx
>  	select ARM_AMBA
>  	select ARM_GIC
>  	select ARM_TIMER_SP804
> +	select ARCH_WANT_OPTIONAL_GPIOLIB
>  	select CACHE_L2X0
>  	select CLKSRC_OF
>  	select GENERIC_CLOCKEVENTS

No need for this to be a separate patch, I've folded it into patch 1.

Kevin
