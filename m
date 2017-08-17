From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 17 Aug 2017 13:58:34 +0000
Subject: [PATCH 6/7] ARM: dts: stm32: Add USB FS support for STM32F746 MCU
In-Reply-To: <804e0eb3-88a0-2847-9330-0f92d36f9f99@cogentembedded.com>
References: <1502962386-6683-1-git-send-email-amelie.delaunay@st.com>
 <1502962386-6683-7-git-send-email-amelie.delaunay@st.com>
 <804e0eb3-88a0-2847-9330-0f92d36f9f99@cogentembedded.com>
Message-ID: <6623149d-fe9d-a173-52d5-ee558d55ece4@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/17/2017 12:47 PM, Sergei Shtylyov wrote:
> On 8/17/2017 12:33 PM, Amelie Delaunay wrote:
> 
>> This patch adds the USB pins and nodes for USB FS core on STM32F746 SoC.
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   arch/arm/boot/dts/stm32f746.dtsi | 31 +++++++++++++++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32f746.dtsi 
>> b/arch/arm/boot/dts/stm32f746.dtsi
>> index fcfe5a6..a9476ea 100644
>> --- a/arch/arm/boot/dts/stm32f746.dtsi
>> +++ b/arch/arm/boot/dts/stm32f746.dtsi
>> @@ -419,6 +419,28 @@
>>                       slew-rate = <2>;
>>                   };
>>               };
>> +
>> +            usbotg_fs_pins_a: usbotg_fs at 0 {
> 
>     Dashes are preferred to underlines in the node names.
You're right. I'll fix it in v2. Thanks.
> 
> [...]
> 
> MBR, Sergei

Regards,
Amelie
