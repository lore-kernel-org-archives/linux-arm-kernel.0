From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 11:18:47 -0700
Subject: [PATCH] arm: config: omap2plus_defconfig: switch over to LZMA
 compression
In-Reply-To: <1422638336-24243-1-git-send-email-balbi@ti.com>
References: <1422638336-24243-1-git-send-email-balbi@ti.com>
Message-ID: <20150316181847.GU5264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150130 09:22]:
> LZMA compression makes about 33% smaller zImage
> with just a slight extra decompression time.
> 
> Before this patch, zImage built with o2+_dc
> is 4.5MiB and after it's about 3.3MiB.
> 
> Suggested-by: David Cohen <david.a.cohen@linux.intel.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applying this into omap-for-v4.1/defconfig thanks.

Tony

> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index b7386524c356..742c62b6d663 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -1,3 +1,4 @@
> +CONFIG_KERNEL_LZMA=y
>  CONFIG_SYSVIPC=y
>  CONFIG_POSIX_MQUEUE=y
>  CONFIG_FHANDLE=y
> -- 
> 2.3.0-rc1
> 
