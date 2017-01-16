From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Mon, 16 Jan 2017 17:03:24 +0100
Subject: [PATCH v1 7/7] ARM: configs: Add STM32 LTDC support in STM32
 defconfig
In-Reply-To: <1484573344-11609-8-git-send-email-yannick.fertre@st.com>
References: <1484573344-11609-1-git-send-email-yannick.fertre@st.com>
 <1484573344-11609-8-git-send-email-yannick.fertre@st.com>
Message-ID: <d822b50d-acfb-bde4-4df7-9f4ff7579e3f@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 01/16/2017 02:29 PM, Yannick Fertre wrote:
> Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
> ---

commit header "ARM: configs: stm32: ADD LDTC support"

>  arch/arm/configs/stm32_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
> index 29068f5..e3974d9 100644
> --- a/arch/arm/configs/stm32_defconfig
> +++ b/arch/arm/configs/stm32_defconfig
> @@ -71,3 +71,8 @@ CONFIG_MAGIC_SYSRQ=y
>  # CONFIG_FTRACE is not set
>  CONFIG_CRC_ITU_T=y
>  CONFIG_CRC7=y
> +CONFIG_DRM=y
> +CONFIG_DRM_ST=y
> +CONFIG_DRM_PANEL=y
> +CONFIG_DRM_PANEL_SIMPLE=y
> +CONFIG_BACKLIGHT_LCD_SUPPORT=y
>
