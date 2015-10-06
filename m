From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 06 Oct 2015 09:39:26 +0900
Subject: [PATCHv2 2/2] ARM: multi_v7_defconfig: Enable rtl8152 ethernet
 driver for Odroid-XU4
In-Reply-To: <1444035629-1173-2-git-send-email-linux.amoon@gmail.com>
References: <1444035629-1173-1-git-send-email-linux.amoon@gmail.com>
 <1444035629-1173-2-git-send-email-linux.amoon@gmail.com>
Message-ID: <5613183E.60509@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.10.2015 18:00, Anand Moon wrote:
> Odroid XU4 supports RTL8152/RTL8153 Based USB 3.0 Ethernet Adapters.
> Support speed upto 10/100/1000 Mbit Ethernet LAN.
> 

Just:
"Odroid XU4 has a RTL8153-CG gigabit Ethernet adapter, connected over
USB 3.0."

The message can be fixed when applying, so:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof



> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> 
> ---
> Changes: Fixed the commit log.
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
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
> 
