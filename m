From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 21 Sep 2018 11:38:36 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable panel OTM8009A
In-Reply-To: <1534776349-4036-1-git-send-email-yannick.fertre@st.com>
References: <1534776349-4036-1-git-send-email-yannick.fertre@st.com>
Message-ID: <e7118f91-bf21-549a-a9bd-f92367d1c277@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yannick

On 08/20/2018 04:45 PM, Yannick Fertr? wrote:
> Enable panel OTM8009A as loadable module.
> 
> Signed-off-by: Yannick Fertr? <yannick.fertre@st.com>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index d2b7f35..b6732df 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -648,6 +648,7 @@ CONFIG_DRM_TEGRA=y
>   CONFIG_DRM_STM=m
>   CONFIG_DRM_STM_DSI=m
>   CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
> +CONFIG_DRM_PANEL_ORISETECH_OTM8009A=m
>   CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
>   CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
>   CONFIG_DRM_PANEL_SIMPLE=y
> 
Applied on stm32-next.

Thanks.
Alex
