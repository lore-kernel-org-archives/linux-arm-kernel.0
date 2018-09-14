From: yannick.fertre@st.com (Yannick FERTRE)
Date: Fri, 14 Sep 2018 12:39:26 +0000
Subject: [PATCH] ARM: multi_v7_defconfig: enable panel OTM8009A
In-Reply-To: <1534776349-4036-1-git-send-email-yannick.fertre@st.com>
References: <1534776349-4036-1-git-send-email-yannick.fertre@st.com>
Message-ID: <8833c439-bc75-d364-f27f-18af31318f02@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Gentle ping


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

-- 
Yannick Fertr? | TINA: 166 7152 | Tel: +33 244027152 | Mobile: +33 620600270
Microcontrollers and Digital ICs Group | Microcontrolleurs Division
