From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 25 Jun 2012 10:36:22 +0200
Subject: [PATCH v3 6/7] ARM: at91: remove mach/irqs.h
In-Reply-To: <1340467906-12382-1-git-send-email-ludovic.desroches@atmel.com>
References: <1340467539-12294-1-git-send-email-ludovic.desroches@atmel.com>
 <1340467906-12382-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <4FE82306.2030103@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2012 06:11 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> mach/irqs only defines FIQ_START which doesn't appear to be used anywhere
> so remove it.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/include/mach/irqs.h |   29 -----------------------------
>  1 files changed, 0 insertions(+), 29 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/include/mach/irqs.h
> 
> diff --git a/arch/arm/mach-at91/include/mach/irqs.h b/arch/arm/mach-at91/include/mach/irqs.h
> deleted file mode 100644
> index cab60d5..0000000
> --- a/arch/arm/mach-at91/include/mach/irqs.h
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -/*
> - * arch/arm/mach-at91/include/mach/irqs.h
> - *
> - *  Copyright (C) 2004 SAN People
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> - */
> -
> -#ifndef __ASM_ARCH_IRQS_H
> -#define __ASM_ARCH_IRQS_H
> -
> -#include <linux/io.h>
> -
> -/* FIQ is AIC source 0. */
> -#define FIQ_START AT91_ID_FIQ
> -
> -#endif
> 


-- 
Nicolas Ferre
