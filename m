From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 14 Sep 2018 15:54:48 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable panel RM68200
In-Reply-To: <625f707a-681a-8d60-3ee9-5f5ba4767751@st.com>
References: <1534776612-4448-1-git-send-email-yannick.fertre@st.com>
 <625f707a-681a-8d60-3ee9-5f5ba4767751@st.com>
Message-ID: <45705cc9-ab59-076e-7876-54835a5095a3@st.com>
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
>> Enable panel raydium RM68200 as loadable module.
>>
>> Signed-off-by: Yannick Fertr? <yannick.fertre@st.com>
>> ---
>>?? arch/arm/configs/multi_v7_defconfig | 1 +
>>?? 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index 7e1c543..fcf5b34 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -646,6 +646,7 @@ CONFIG_DRM_SUN4I=m
>>?? CONFIG_DRM_FSL_DCU=m
>>?? CONFIG_DRM_TEGRA=y
>>?? CONFIG_DRM_PANEL_SAMSUNG_LD9040=m
>> +CONFIG_DRM_PANEL_RAYDIUM_RM68200=m
>>?? CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
>>?? CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
>>?? CONFIG_DRM_PANEL_SIMPLE=y
> 
> -- 
> Yannick Fertr? | TINA: 166 7152 | Tel: +33 244027152 | Mobile: +33 620600270
> Microcontrollers and Digital ICs Group | Microcontrolleurs Division
