From: gerg@uclinux.org (Greg Ungerer)
Date: Mon, 25 Nov 2013 20:51:33 +1000
Subject: [PATCH] ARM: ks8695: delete local <mach/gpio.h> header
In-Reply-To: <1385037362-24278-1-git-send-email-linus.walleij@linaro.org>
References: <1385037362-24278-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <52932BB5.5050405@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 21/11/13 22:36, Linus Walleij wrote:
> This header is not used by anything, and since the arch does
> not specify NEED_MACH_GPIO_H it is not included into
> <linux/gpio.h> either. Delete it.
>
> Cc: Greg Ungerer <gerg@uclinux.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Greg: can you ACK this so I can take it through the GPIO
> tree?

Sure thing.

Acked-by: Greg Ungerer <gerg@uclinux.org>

Regards
Greg


> ---
>   arch/arm/mach-ks8695/include/mach/gpio.h | 19 -------------------
>   1 file changed, 19 deletions(-)
>   delete mode 100644 arch/arm/mach-ks8695/include/mach/gpio.h
>
> diff --git a/arch/arm/mach-ks8695/include/mach/gpio.h b/arch/arm/mach-ks8695/include/mach/gpio.h
> deleted file mode 100644
> index f5fda36e4512..000000000000
> --- a/arch/arm/mach-ks8695/include/mach/gpio.h
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -/*
> - * arch/arm/mach-ks8695/include/mach/gpio.h
> - *
> - * Copyright (C) 2006 Andrew Victor
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -
> -#ifndef __ASM_ARCH_GPIO_H_
> -#define __ASM_ARCH_GPIO_H_
> -
> -/*
> - * Map IRQ number to GPIO line.
> - */
> -extern int irq_to_gpio(unsigned int irq);
> -
> -#endif
>
