From: horms@verge.net.au (Simon Horman)
Date: Thu, 18 Apr 2013 10:09:22 +0900
Subject: [PATCH] ARM: shmobile: add missing include of of.h
In-Reply-To: <1366225302-23150-1-git-send-email-olof@lixom.net>
References: <1366225302-23150-1-git-send-email-olof@lixom.net>
Message-ID: <20130418010922.GB4511@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 12:01:42PM -0700, Olof Johansson wrote:
> Fixes the following build warnings:
> 
> In file included from arch/arm/mach-shmobile/setup-r8a7779.c:25:0:
> include/linux/of_platform.h:107:13: warning: 'struct of_device_id' declared inside parameter list [enabled by default]
> include/linux/of_platform.h:107:13: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
> include/linux/of_platform.h:107:13: warning: 'struct device_node' declared inside parameter list [enabled by default]
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> Hi Simon,
> 
> I'll just apply this directly if it's OK with you?

Its ok with me.

Acked-by: Simon Horman <horms+renesas@verge.net.au>


> 
> 
> 
> -Olof
> 
>  arch/arm/mach-shmobile/setup-r8a7779.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
> index b0b3948..7413fc0 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> @@ -22,6 +22,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_data/gpio-rcar.h>
>  #include <linux/platform_device.h>
> -- 
> 1.8.1.192.gc4361b8
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
