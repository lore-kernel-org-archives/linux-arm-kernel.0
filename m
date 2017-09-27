From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 27 Sep 2017 08:59:55 +0200
Subject: [RESEND PATCH v5 4/4] ARM: configs: stm32: Add DMAMUX support in
 STM32 defconfig
In-Reply-To: <20170926164603.GP30097@localhost>
References: <1506065492-31478-1-git-send-email-pierre-yves.mordret@st.com>
 <1506065492-31478-5-git-send-email-pierre-yves.mordret@st.com>
 <20170926164603.GP30097@localhost>
Message-ID: <cbbfc620-064c-e400-0490-a1ce5b26c894@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod

On 09/26/2017 06:46 PM, Vinod Koul wrote:
> On Fri, Sep 22, 2017 at 09:31:32AM +0200, Pierre-Yves MORDRET wrote:
>> This patch adds DMAMUX support in STM32 defconfig file
> 
> Need ACK from ARM folks on this.

I will take it in my pull request.

Regards
Alex
> 
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
>> ---
>>   Version history:
>>      v5:
>>      v4:
>>      v3:
>>      v2:
>>          * None
>> ---
>> ---
>>   arch/arm/configs/stm32_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
>> index 90e5c46..988f395 100644
>> --- a/arch/arm/configs/stm32_defconfig
>> +++ b/arch/arm/configs/stm32_defconfig
>> @@ -67,6 +67,7 @@ CONFIG_RTC_CLASS=y
>>   CONFIG_RTC_DRV_STM32=y
>>   CONFIG_DMADEVICES=y
>>   CONFIG_STM32_DMA=y
>> +CONFIG_STM32_DMAMUX=y
>>   CONFIG_IIO=y
>>   CONFIG_STM32_ADC_CORE=y
>>   CONFIG_STM32_ADC=y
>> -- 
>> 2.7.4
>>
> 
