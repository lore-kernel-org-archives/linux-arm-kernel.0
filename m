From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Tue, 20 Oct 2015 18:25:00 -0700
Subject: [PATCH 2/5] mmc: omap_hsmmc: Enable omap_hsmmc for Keystone 2
In-Reply-To: <1445377809-12516-2-git-send-email-fcooper@ti.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
 <1445377809-12516-2-git-send-email-fcooper@ti.com>
Message-ID: <5626E96C.2090002@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2015 2:50 PM, Franklin S Cooper Jr wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
>
> Enable omap_hsmmc for Keystone 2 architecture which reuses the HSMMC
> IP found on OMAP platforms.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>   drivers/mmc/host/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 8a1e349..2ccec71 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -366,7 +366,7 @@ config MMC_OMAP
>   config MMC_OMAP_HS
>   	tristate "TI OMAP High Speed Multimedia Card Interface support"
>   	depends on HAS_DMA
> -	depends on ARCH_OMAP2PLUS || COMPILE_TEST
> +	depends on ARCH_OMAP2PLUS || ARCH_KEYSTONE || COMPILE_TEST
>   	help
>   	  This selects the TI OMAP High Speed Multimedia card Interface.
>   	  If you have an omap2plus board with a Multimedia Card slot,
>
Please send this to MMC tree.

Regards,
Santosh
