From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 26 Jun 2018 14:13:20 +0200
Subject: [PATCH 3/3] ARM: multi_v7_defconfig: enable STM32 SPI
In-Reply-To: <120d8997-3184-bfed-26b7-e0ac7d995b74@st.com>
References: <1526566904-24514-1-git-send-email-amelie.delaunay@st.com>
 <1526566904-24514-4-git-send-email-amelie.delaunay@st.com>
 <e3bd3097-fbde-b790-e2b3-d78fb34b849d@st.com>
 <120d8997-3184-bfed-26b7-e0ac7d995b74@st.com>
Message-ID: <f61c7908-8046-1709-94cf-a4066a330299@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/26/2018 01:47 PM, Amelie DELAUNAY wrote:
> Hi Alex
> 
> On 06/26/2018 10:44 AM, Alexandre Torgue wrote:
>> Hi Am?lie
>> 
>> On 05/17/2018 04:21 PM, Amelie Delaunay wrote:
>>> Enable the STM32 SPI driver, implemented on STM32MP1 SoC.
>>>
>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>>> ---
>>> ? arch/arm/configs/multi_v7_defconfig | 1 +
>>> ? 1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/configs/multi_v7_defconfig 
>>> b/arch/arm/configs/multi_v7_defconfig
>>> index 89167cd..f990335 100644
>>> --- a/arch/arm/configs/multi_v7_defconfig
>>> +++ b/arch/arm/configs/multi_v7_defconfig
>>> @@ -411,6 +411,7 @@ CONFIG_SPI_S3C64XX=m
>>> ? CONFIG_SPI_SH_MSIOF=m
>>> ? CONFIG_SPI_SH_HSPI=y
>>> ? CONFIG_SPI_SIRF=y
>>> +CONFIG_SPI_STM32=y
>>> ? CONFIG_SPI_SUN4I=y
>>> ? CONFIG_SPI_SUN6I=y
>>> ? CONFIG_SPI_TEGRA114=y
>>>
>> 
>> Driver which are are not "vital" to boot STM32 platform should be 
>> defined as module. It's the case for this one. Isn't ?
>> 
> 
> You're right. I'll send v2 with CONFIG_SPI_STM32=m ASAP. Should I resend
> the whole patchset (with DT), or just this patch and you take the DT
> patches as they are ?
> 

No, you can just resend this one. I will take DT part from this version.

Regards
Alex

> Regards,
> Amelie
