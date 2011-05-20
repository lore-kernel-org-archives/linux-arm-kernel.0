From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 May 2011 22:48:45 +0200
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <201105181047.17309.arnd@arndb.de>
References: <201105181047.17309.arnd@arndb.de>
Message-ID: <BANLkTin53hToQ-X8MgbtEp97ZW2OXePsKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/18 Arnd Bergmann <arnd@arndb.de>:

> Maintainers: If you are happy with the layout of the process,
> please ack this patch, otherwise please comment.
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fce5e6..942d052 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -630,6 +630,17 @@ S: Maintained
> ?F: ? ? drivers/amba/
> ?F: ? ? include/linux/amba/bus.h
>
> +ARM SUBARCHITECTURES
> +M: ? ? Arnd Bergmann <arnd@arndb.de>
> +M: ? ? Nicolas Pitre <nico@fluxnic.net>
> +M: ? ? Thomas Gleixner <tglx@linutronix.de>
> +M: ? ? arm at kernel.org
> +L: ? ? linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> +S: ? ? MAINTAINED
> +F: ? ? arch/arm/mach-*/
> +F: ? ? arch/arm/plat-*/
> +T: ? ? git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-subarch.git

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
