From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Sat, 26 Sep 2009 17:03:11 +0200
Subject: [PATCH] ARM: Remove unused CONFIG SA1100_H3XXX
In-Reply-To: <1253976606.4568.42.camel@ht.satnam>
References: <1253976606.4568.42.camel@ht.satnam>
Message-ID: <20090926170311.0a87fac8.kristoffer.ericson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Sep 2009 20:20:06 +0530
Jaswinder Singh Rajput <jaswinder@kernel.org> wrote:

> 
> Removed unused CONFIG SA1100_H3XXX from Kconfig and defconfig

Without applying it to check for formatting stuff it looks
resonable. Is 3600 in any good shape nowadays?

> 
> Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
> Cc: Dmitry Artamonow <mad_soft@inbox.ru>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> Cc: Russell King <rmk+lkml@arm.linux.org.uk>
> ---
>  arch/arm/configs/h3600_defconfig |    1 -
>  arch/arm/mach-sa1100/Kconfig     |    5 -----
>  2 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
> index 1502957..f6aed77 100644
> --- a/arch/arm/configs/h3600_defconfig
> +++ b/arch/arm/configs/h3600_defconfig
> @@ -90,7 +90,6 @@ CONFIG_ARCH_SA1100=y
>  # CONFIG_SA1100_COLLIE is not set
>  # CONFIG_SA1100_H3100 is not set
>  CONFIG_SA1100_H3600=y
> -CONFIG_SA1100_H3XXX=y
>  # CONFIG_SA1100_BADGE4 is not set
>  # CONFIG_SA1100_JORNADA720 is not set
>  # CONFIG_SA1100_HACKKIT is not set
> diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
> index 81ffff7..4e5c07f 100644
> --- a/arch/arm/mach-sa1100/Kconfig
> +++ b/arch/arm/mach-sa1100/Kconfig
> @@ -71,11 +71,6 @@ config SA1100_H3600
>  	  <http://www.handhelds.org/Compaq/index.html#iPAQ_H3600>
>  	  <http://www.compaq.com/products/handhelds/pocketpc/>
>  
> -config SA1100_H3XXX
> -	bool
> -	depends on SA1100_H3100 || SA1100_H3600
> -	default y
> -
>  config SA1100_BADGE4
>  	bool "HP Labs BadgePAD 4"
>  	select SA1111
> -- 
> 1.6.0.6
> 
> 


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>
