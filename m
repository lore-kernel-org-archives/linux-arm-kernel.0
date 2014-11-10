From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Nov 2014 10:28:00 +0000
Subject: [PATCH 06/13] ARM: multi_v7_defconfig: Enable stih407 usb picophy
In-Reply-To: <1415361475-6218-7-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
 <1415361475-6218-7-git-send-email-peter.griffin@linaro.org>
Message-ID: <20141110102800.GQ21424@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 07 Nov 2014, Peter Griffin wrote:

> This patch enables the picoPHY usb phy which is used by
> the usb2 and usb3 host controllers when controlling usb2/1.1
> devices. It is found in stih407 family SoC's from STMicroelectronics.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index e13ab7e..ac7b536 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -427,6 +427,7 @@ CONFIG_OMAP_USB2=y
>  CONFIG_TI_PIPE3=y
>  CONFIG_PHY_MIPHY365X=y
>  CONFIG_PHY_STIH41X_USB=y
> +CONFIG_PHY_STIH407_USB=y
>  CONFIG_PHY_SUN4I_USB=y
>  CONFIG_EXT4_FS=y
>  CONFIG_VFAT_FS=y

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
