From: nm@ti.com (Nishanth Menon)
Date: Thu, 17 Nov 2016 20:52:17 -0600
Subject: [RFC 2/6] drm/etnaviv: allow building etnaviv on omap devices
In-Reply-To: <20161118024436.13447-2-robertcnelson@gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-2-robertcnelson@gmail.com>
Message-ID: <32c19244-e244-ba57-9f66-b766e71ea3f0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2016 08:44 PM, Robert Nelson wrote:

Could we write at least a oneline commit message? :)

> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Christian Gmeiner <christian.gmeiner@gmail.com>
> CC: Russell King <rmk+kernel@arm.linux.org.uk>
> CC: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/gpu/drm/etnaviv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
> index 2cde7a5..b776f41 100644
> --- a/drivers/gpu/drm/etnaviv/Kconfig
> +++ b/drivers/gpu/drm/etnaviv/Kconfig
> @@ -2,7 +2,7 @@
>  config DRM_ETNAVIV
>  	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
>  	depends on DRM
> -	depends on ARCH_MXC || ARCH_DOVE
> +	depends on ARCH_MXC || ARCH_DOVE || ARCH_OMAP2PLUS
>  	select SHMEM
>  	select TMPFS
>  	select IOMMU_API
>


-- 
Regards,
Nishanth Menon
