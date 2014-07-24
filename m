From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 24 Jul 2014 17:31:46 +0800
Subject: [PATCH v5 4/4] ARM: prima2_defconfig: enable PWM and sirf PWM
 driver
In-Reply-To: <1405475714-10006-5-git-send-email-huayi.li@csr.com>
References: <1405475714-10006-1-git-send-email-huayi.li@csr.com>
 <1405475714-10006-5-git-send-email-huayi.li@csr.com>
Message-ID: <CAGsJ_4xoJ832rtSigL2WxRZGhmxy33Mn-MtrRzS57j7T0axC5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-07-16 9:55 GMT+08:00 Huayi Li <huayi.li@csr.com>:
> Signed-off-by: Huayi Li <huayi.li@csr.com>

Acked-by: Barry Song <Baohua.Song@csr.com>

> ---
>  arch/arm/configs/prima2_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/prima2_defconfig b/arch/arm/configs/prima2_defconfig
> index 23591db..303204a 100644
> --- a/arch/arm/configs/prima2_defconfig
> +++ b/arch/arm/configs/prima2_defconfig
> @@ -50,6 +50,8 @@ CONFIG_DMADEVICES_DEBUG=y
>  CONFIG_DMADEVICES_VDEBUG=y
>  CONFIG_SIRF_DMA=y
>  # CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_PWM=y
> +CONFIG_PWM_SIRF=y
>  CONFIG_EXT2_FS=y
>  CONFIG_MSDOS_FS=y
>  CONFIG_VFAT_FS=y
> --
> 1.9.3
>
