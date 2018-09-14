From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 14 Sep 2018 15:54:37 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable STM32 DRM support
In-Reply-To: <99c886e9-14ee-b1e6-1825-25a2d6623083@st.com>
References: <1534776651-4617-1-git-send-email-yannick.fertre@st.com>
 <99c886e9-14ee-b1e6-1825-25a2d6623083@st.com>
Message-ID: <c44f9794-3f2e-4661-1aa8-1277a5c4e883@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/14/2018 02:39 PM, Yannick FERTRE wrote:
> Hi,
> 
> Gentle ping
> 
> 
It'll be merged in my next PR for 4.20

> On 08/20/2018 04:50 PM, Yannick Fertr? wrote:
>> Enable DRM support for STMicroelectronics as loadable module.
>>
>> Signed-off-by: Yannick Fertr? <yannick.fertre@st.com>
>> ---
>>?? arch/arm/configs/multi_v7_defconfig | 1 +
>>?? 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 7e1c543..d1a2fbf 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -645,6 +645,7 @@ CONFIG_DRM_RCAR_LVDS=y
>>?? CONFIG_DRM_SUN4I=m
>>?? CONFIG_DRM_FSL_DCU=m
>>?? CONFIG_DRM_TEGRA=y
>> +CONFIG_DRM_STM=m
>>?? CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
>>?? CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
>>?? CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
> 
> -- 
> Yannick Fertr? | TINA: 166 7152 | Tel: +33 244027152 | Mobile: +33 620600270
> Microcontrollers and Digital ICs Group | Microcontrolleurs Division
