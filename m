From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 21 Sep 2018 11:37:19 +0200
Subject: [PATCH 1/6] ARM: multi_v7_defconfig: enable backlight gpio
In-Reply-To: <1534772815-3083-1-git-send-email-yannick.fertre@st.com>
References: <1534772815-3083-1-git-send-email-yannick.fertre@st.com>
Message-ID: <24afa9e5-b108-0f1c-f506-7bceaf2dac5a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yannick

On 08/20/2018 03:46 PM, Yannick Fertr? wrote:
> Enable generic GPIO based backlight driver.
> 
> Signed-off-by: Yannick Fertr? <yannick.fertre@st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 23f5b67..bbd5c8c 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -664,6 +664,7 @@ CONFIG_BACKLIGHT_CLASS_DEVICE=y
>   CONFIG_LCD_PLATFORM=m
>   CONFIG_BACKLIGHT_PWM=y
>   CONFIG_BACKLIGHT_AS3711=y
> +CONFIG_BACKLIGHT_GPIO=y
>   CONFIG_FRAMEBUFFER_CONSOLE=y
>   CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
>   CONFIG_SOUND=m
> 
Applied on stm32-next.

Thanks.
Alex
