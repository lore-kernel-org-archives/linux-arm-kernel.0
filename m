From: olof@lixom.net (Olof Johansson)
Date: Fri, 20 Dec 2013 12:16:32 -0800
Subject: [PATCH] ARM: multi_v7: copy most options from tegra_defconfig
In-Reply-To: <1387569848-16563-1-git-send-email-swarren@wwwdotorg.org>
References: <1387569848-16563-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CAOesGMh4PkdTh8EP1WS9-_5cVe1NWuNQPbkskk7hJhtbBEPWBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 12:04 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> @@ -165,21 +276,47 @@ CONFIG_DW_DMAC=y
>  CONFIG_TEGRA20_APB_DMA=y
>  CONFIG_STE_DMA40=y
>  CONFIG_SIRF_DMA=y
> -CONFIG_TI_EDMA=y
>  CONFIG_PL330_DMA=y
>  CONFIG_IMX_SDMA=y
>  CONFIG_IMX_DMA=y
>  CONFIG_MXS_DMA=y
>  CONFIG_DMA_OMAP=y
> +CONFIG_STAGING=y
> +CONFIG_SENSORS_ISL29018=y
> +CONFIG_SENSORS_ISL29028=y
> +CONFIG_MFD_NVEC=y
> +CONFIG_KEYBOARD_NVEC=y
> +CONFIG_SERIO_NVEC_PS2=y
> +CONFIG_NVEC_POWER=y
> +CONFIG_NVEC_PAZ00=y
> +CONFIG_TEGRA_IOMMU_GART=y
> +CONFIG_TEGRA_IOMMU_SMMU=y
> +CONFIG_MEMORY=y
> +CONFIG_IIO=y
> +CONFIG_AK8975=y
>  CONFIG_PWM=y
> +CONFIG_PWM_TEGRA=y
>  CONFIG_PWM_VT8500=y
> +CONFIG_OMAP_USB2=y
> +CONFIG_EXT2_FS=y
> +CONFIG_EXT2_FS_XATTR=y
> +CONFIG_EXT2_FS_POSIX_ACL=y
> +CONFIG_EXT2_FS_SECURITY=y
> +CONFIG_EXT3_FS=y
> +CONFIG_EXT3_FS_POSIX_ACL=y
> +CONFIG_EXT3_FS_SECURITY=y

I think it makes sense to just enable EXT4_USE_FOR_EXT23 instead.

>  CONFIG_EXT4_FS=y
> +CONFIG_VFAT_FS=y
>  CONFIG_TMPFS=y
> +CONFIG_SQUASHFS=y
> +CONFIG_SQUASHFS_LZO=y
> +CONFIG_SQUASHFS_XZ=y
>  CONFIG_NFS_FS=y
>  CONFIG_NFS_V3_ACL=y
>  CONFIG_NFS_V4=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_DEBUG_FS=y
> -CONFIG_DEBUG_KERNEL=y

Why are you disabling DEBUG_KERNEL?


-Olof
