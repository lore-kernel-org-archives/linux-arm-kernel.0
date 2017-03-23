From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 23 Mar 2017 18:26:59 +0100
Subject: [PATCH v4 8/8] ARM: configs: Add STM32 panel simple support in
 STM32 defconfig
In-Reply-To: <1489597334-16896-9-git-send-email-yannick.fertre@st.com>
References: <1489597334-16896-1-git-send-email-yannick.fertre@st.com>
 <1489597334-16896-9-git-send-email-yannick.fertre@st.com>
Message-ID: <5dfdedd9-9758-ed27-1022-d54ff5228303@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/15/2017 06:02 PM, Yannick Fertre wrote:
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---

Same remarks than patch7

>  arch/arm/configs/stm32_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index 9c6ba54e..f7ddf29b 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -50,6 +50,8 @@ CONFIG_SERIAL_STM32_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
>  # CONFIG_HWMON is not set
>  CONFIG_DRM=y
> +CONFIG_DRM_PANEL_SIMPLE=y
> +CONFIG_BACKLIGHT_LCD_SUPPORT=y
>  CONFIG_MFD_SYSCON=y
>  # CONFIG_USB_SUPPORT is not set
>  CONFIG_NEW_LEDS=y
>
