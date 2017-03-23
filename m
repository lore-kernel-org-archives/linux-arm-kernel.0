From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Thu, 23 Mar 2017 18:26:04 +0100
Subject: [PATCH v4 7/8] ARM: configs: Add STM32 LTDC support in STM32
 defconfig
In-Reply-To: <1489597334-16896-8-git-send-email-yannick.fertre@st.com>
References: <1489597334-16896-1-git-send-email-yannick.fertre@st.com>
 <1489597334-16896-8-git-send-email-yannick.fertre@st.com>
Message-ID: <583a98e7-bff5-1875-385f-a53569393035@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 03/15/2017 06:02 PM, Yannick Fertre wrote:
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---

Can you change commit header by:" ARM: config: stm32: Add LTDC support"
and can you fill a commit message please ?

>  arch/arm/configs/stm32_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index 436240d..9c6ba54e 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -49,6 +49,7 @@ CONFIG_SERIAL_STM32=y
>  CONFIG_SERIAL_STM32_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
>  # CONFIG_HWMON is not set
> +CONFIG_DRM=y
>  CONFIG_MFD_SYSCON=y
>  # CONFIG_USB_SUPPORT is not set
>  CONFIG_NEW_LEDS=y
>
