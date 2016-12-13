From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 13 Dec 2016 11:03:11 +0100
Subject: [PATCH v6 5/5] ARM: configs: stm32: Add I2C support for STM32
 defconfig
In-Reply-To: <1481559342-6106-6-git-send-email-cedric.madianga@gmail.com>
References: <1481559342-6106-1-git-send-email-cedric.madianga@gmail.com>
 <1481559342-6106-6-git-send-email-cedric.madianga@gmail.com>
Message-ID: <7a48ebd1-94cc-a0e8-6a6c-25ca76aaeed5@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Cedric,

On 12/12/2016 05:15 PM, M'boumba Cedric Madianga wrote:
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>

Can you please add a commit message.

Thx in advance
Alex

> ---
>  arch/arm/configs/stm32_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index e7b56d4..9494eaf 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -52,6 +52,9 @@ CONFIG_SERIAL_NONSTANDARD=y
>  CONFIG_SERIAL_STM32=y
>  CONFIG_SERIAL_STM32_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
> +CONFIG_I2C=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_STM32F4=y
>  # CONFIG_HWMON is not set
>  # CONFIG_USB_SUPPORT is not set
>  CONFIG_NEW_LEDS=y
>
