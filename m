From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Mar 2014 13:23:08 +0900
Subject: [PATCH 58/62] ARM: exynos: add missing include of linux/module.h
In-Reply-To: <1395257399-359545-59-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-59-git-send-email-arnd@arndb.de>
Message-ID: <027101cf43f4$18b17d00$4a147700$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann wrote:
> 
> After the restructuring of the module.h and init.h headers,
> we now need to include this explicitly here.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Arnd,

If you want me to take this fixes for Samsung stuff into samsung tree,
please let me know.

Thanks,
Kukjin

> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-exynos/cpuidle.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-
> exynos/cpuidle.c
> index f57cb91..93d2dec 100644
> --- a/arch/arm/mach-exynos/cpuidle.c
> +++ b/arch/arm/mach-exynos/cpuidle.c
> @@ -14,6 +14,7 @@
>  #include <linux/cpu_pm.h>
>  #include <linux/io.h>
>  #include <linux/export.h>
> +#include <linux/module.h>
>  #include <linux/time.h>
>  #include <linux/platform_device.h>
> 
> --
> 1.8.3.2
