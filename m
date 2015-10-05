From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 5 Oct 2015 08:14:51 +0100
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable rtl8152 ethernet
 driver for Odroid-XU4
In-Reply-To: <1444026570-14076-2-git-send-email-linux.amoon@gmail.com>
References: <1444026570-14076-1-git-send-email-linux.amoon@gmail.com>
 <1444026570-14076-2-git-send-email-linux.amoon@gmail.com>
Message-ID: <20151005071451.GD3377@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 05 Oct 2015, Anand Moon wrote:

> Enable CONFIG_USB_RTL8152 for Odroid-XU4.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Why have you sent this to me?

Please be more selective with your recipient list.  

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 03deb7f..009d714 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -221,6 +221,7 @@ CONFIG_BROADCOM_PHY=y
>  CONFIG_ICPLUS_PHY=y
>  CONFIG_MICREL_PHY=y
>  CONFIG_USB_PEGASUS=y
> +CONFIG_USB_RTL8152=y
>  CONFIG_USB_USBNET=y
>  CONFIG_USB_NET_SMSC75XX=y
>  CONFIG_USB_NET_SMSC95XX=y

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
