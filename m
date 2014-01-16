From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 16 Jan 2014 17:50:24 +0900
Subject: [PATCH] ARM: exynos_defconfig: Update EHCI config entry
In-Reply-To: <1389861264-7305-1-git-send-email-tushar.behera@linaro.org>
References: <1389861264-7305-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <000101cf1297$fef674c0$fce35e40$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 16, 2014 5:34 PM, Tushar Behera wrote:
> 
> Commit 29824c167bea ("USB: host: Rename ehci-s5p to ehci-exynos")
> renamed the config entry of EHCI host driver. Similar change needs
> to be done in exynos_defconfig as well.
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>

(+cc Vivek Gautam, Yulgon Kim, Julius Werner)

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Yes, right.
I overlooked 'exynos_defconfig', when I changed the name of
Exynos EHCI driver. Thank you for sending the patch. :-)

Best regards,
Jingoo Han

> ---
>  arch/arm/configs/exynos_defconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index dbe1f1c..4ce7b70 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -94,7 +94,7 @@ CONFIG_FONT_7x14=y
>  CONFIG_LOGO=y
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
> -CONFIG_USB_EHCI_S5P=y
> +CONFIG_USB_EHCI_EXYNOS=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_DWC3=y
>  CONFIG_USB_PHY=y
> --
> 1.7.9.5
