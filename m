From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Nov 2012 11:10:08 +0900
Subject: [PATCH 03/24] MAINTAINERS: remove arch/arm/plat-s5p/
In-Reply-To: <1353716808-16375-4-git-send-email-cesarb@cesarb.net>
References: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
 <1353716808-16375-4-git-send-email-cesarb@cesarb.net>
Message-ID: <122701cdc9e8$d397d0b0$7ac77210$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cesar Eduardo Barros wrote:
> 
> These files were merged into plat-samsung.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 041872a..9bdd5f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1074,7 +1074,6 @@ W:	http://www.fluff.org/ben/linux/
>  S:	Maintained
>  F:	arch/arm/plat-samsung/
>  F:	arch/arm/plat-s3c24xx/
> -F:	arch/arm/plat-s5p/
>  F:	arch/arm/mach-s3c24*/
>  F:	arch/arm/mach-s3c64xx/
>  F:	drivers/*/*s3c2410*
> @@ -1105,7 +1104,6 @@ M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
>  L:	linux-arm-kernel at lists.infradead.org
>  L:	linux-media at vger.kernel.org
>  S:	Maintained
> -F:	arch/arm/plat-s5p/dev-fimc*
>  F:	arch/arm/plat-samsung/include/plat/*fimc*
>  F:	drivers/media/platform/s5p-fimc/
> 
> @@ -1116,7 +1114,7 @@ M:	Jeongtae Park <jtp.park@samsung.com>
>  L:	linux-arm-kernel at lists.infradead.org
>  L:	linux-media at vger.kernel.org
>  S:	Maintained
> -F:	arch/arm/plat-s5p/dev-mfc.c
> +F:	arch/arm/plat-samsung/s5p-dev-mfc.c
>  F:	drivers/media/platform/s5p-mfc/
> 
>  ARM/SAMSUNG S5P SERIES TV SUBSYSTEM SUPPORT
> --
> 1.7.11.7
