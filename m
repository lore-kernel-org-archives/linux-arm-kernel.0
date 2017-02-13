From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 13 Feb 2017 09:25:27 +0100
Subject: [PATCH v2 7/7] ARM: configs: stm32: ADD LDTC support
In-Reply-To: <1486740274-25958-8-git-send-email-yannick.fertre@st.com>
References: <1486740274-25958-1-git-send-email-yannick.fertre@st.com>
 <1486740274-25958-8-git-send-email-yannick.fertre@st.com>
Message-ID: <5779027b-1d0f-afdf-ec21-4a93bb091a40@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yannick

On 02/10/2017 04:24 PM, Yannick Fertre wrote:
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>

Please add a commit message.

> ---
>  arch/arm/configs/stm32_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index e995209..d6a00b8 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -70,3 +70,8 @@ CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_FTRACE is not set
>  CONFIG_CRC_ITU_T=y
>  CONFIG_CRC7=y
> +CONFIG_DRM=y
> +CONFIG_DRM_ST=y
> +CONFIG_DRM_PANEL=y
> +CONFIG_DRM_PANEL_SIMPLE=y
> +CONFIG_BACKLIGHT_LCD_SUPPORT=y
>
