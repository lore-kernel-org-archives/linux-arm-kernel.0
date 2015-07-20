From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 20 Jul 2015 09:29:23 +0200
Subject: [PATCH 1/7] ARM: at91: Remove clk-provider.h include
In-Reply-To: <1436568347-24554-2-git-send-email-sboyd@codeaurora.org>
References: <1436568347-24554-1-git-send-email-sboyd@codeaurora.org>
 <1436568347-24554-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150720072923.GD15539@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2015 at 15:45:41 -0700, Stephen Boyd wrote :
> This file doesn't use the clk provider APIs. Remove the include.
> 
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> 
> Please ack if you want this to go through clk-tree.
> 
>  arch/arm/mach-at91/at91rm9200.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index eaf58f88ef5d..685826c4a710 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -8,7 +8,6 @@
>   * Licensed under GPLv2 or later.
>   */
>  
> -#include <linux/clk-provider.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
