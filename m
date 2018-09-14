From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 14 Sep 2018 15:54:24 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable STM32 MIPI DSI
In-Reply-To: <e996cebb-f268-b144-4acb-af58e81eac4a@st.com>
References: <1534776782-4941-1-git-send-email-yannick.fertre@st.com>
 <e996cebb-f268-b144-4acb-af58e81eac4a@st.com>
Message-ID: <184ec795-2975-224e-ccad-a2fc61acf904@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/14/2018 02:39 PM, Yannick FERTRE wrote:
> Hi,
> 
> Gentle ping
> 

It'll be merged in my next PR for 4.20

> 
> On 08/20/2018 04:53 PM, Yannick Fertr? wrote:
>> Enable STMicroelectronics specific extensions for Synopsis MIPI DSI
>> as loadable module.
>>
>> Signed-off-by: Yannick Fertr? <yannick.fertre@st.com>
>> ---
>>?? arch/arm/configs/multi_v7_defconfig | 1 +
>>?? 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 7e1c543..4c88cba 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -645,6 +645,7 @@ CONFIG_DRM_RCAR_LVDS=y
>>?? CONFIG_DRM_SUN4I=m
>>?? CONFIG_DRM_FSL_DCU=m
>>?? CONFIG_DRM_TEGRA=y
>> +CONFIG_DRM_STM_DSI=m
>>?? CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
>>?? CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
>>?? CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
> 
> -- 
> Yannick Fertr? | TINA: 166 7152 | Tel: +33 244027152 | Mobile: +33 620600270
> Microcontrollers and Digital ICs Group | Microcontrolleurs Division
