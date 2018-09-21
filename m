From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 21 Sep 2018 11:39:38 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable STM32 MIPI DSI
In-Reply-To: <1534776782-4941-1-git-send-email-yannick.fertre@st.com>
References: <1534776782-4941-1-git-send-email-yannick.fertre@st.com>
Message-ID: <b596862f-3321-d4f6-a01c-e1360c84db4c@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi yannick

On 08/20/2018 04:53 PM, Yannick Fertr? wrote:
> Enable STMicroelectronics specific extensions for Synopsis MIPI DSI
> as loadable module.
> 
> Signed-off-by: Yannick Fertr? <yannick.fertre@st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 7e1c543..4c88cba 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -645,6 +645,7 @@ CONFIG_DRM_RCAR_LVDS=y
>   CONFIG_DRM_SUN4I=m
>   CONFIG_DRM_FSL_DCU=m
>   CONFIG_DRM_TEGRA=y
> +CONFIG_DRM_STM_DSI=m
>   CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
>   CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
>   CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
> 

Applied on stm32-next.

Thanks.
Alex
