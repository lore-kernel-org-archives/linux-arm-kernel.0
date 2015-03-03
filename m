From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 3 Mar 2015 19:40:34 +0100
Subject: [PATCH] ARM: at91/defconfig: remove CONFIG_SYSFS_DEPRECATED
In-Reply-To: <1423173576-10888-1-git-send-email-anthony.harivel@emtrion.de>
References: <1423173576-10888-1-git-send-email-anthony.harivel@emtrion.de>
Message-ID: <54F60022.7090500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/02/2015 22:59, Anthony Harivel a ?crit :
> Recent distributions and userspace tools after 2009/2010 depend on
> the existence of /sys/class/block/, and will not work with this option enabled.
> 
> Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>

Okay:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and added to at91-4.0-fixes.

thanks!

> ---
>  arch/arm/configs/sama5_defconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index c9089c9..59b48563 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -3,8 +3,6 @@
>  CONFIG_SYSVIPC=y
>  CONFIG_IRQ_DOMAIN_DEBUG=y
>  CONFIG_LOG_BUF_SHIFT=14
> -CONFIG_SYSFS_DEPRECATED=y
> -CONFIG_SYSFS_DEPRECATED_V2=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_EMBEDDED=y
>  CONFIG_SLAB=y
> 


-- 
Nicolas Ferre
