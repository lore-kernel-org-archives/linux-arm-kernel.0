From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Mar 2013 21:57:38 +0900
Subject: [PATCH 03/14] MAINTAINERS: remove arch/arm/plat-s3c24xx/
In-Reply-To: <1362275632-20242-4-git-send-email-cesarb@cesarb.net>
References: <1362275632-20242-1-git-send-email-cesarb@cesarb.net>
 <1362275632-20242-4-git-send-email-cesarb@cesarb.net>
Message-ID: <007f01ce18d7$d94ab430$8be01c90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cesar Eduardo Barros wrote:
> 
> This directory was removed by commit 09ec1d7 (ARM: S3C24XX: Remove
> plat-s3c24xx directory in arch/arm/).
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

- Kukjin

> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c074d5..5af82f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1119,7 +1119,6 @@ L:	linux-samsung-soc at vger.kernel.org (moderated
> for non-subscribers)
>  W:	http://www.fluff.org/ben/linux/
>  S:	Maintained
>  F:	arch/arm/plat-samsung/
> -F:	arch/arm/plat-s3c24xx/
>  F:	arch/arm/mach-s3c24*/
>  F:	arch/arm/mach-s3c64xx/
>  F:	drivers/*/*s3c2410*
> --
> 1.7.11.7
