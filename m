From: amelie.delaunay@st.com (Amelie DELAUNAY)
Date: Thu, 17 Aug 2017 13:57:35 +0000
Subject: [PATCH 4/7] ARM: dts: stm32: Enable USB HS on stm32746g-eval
In-Reply-To: <824d41f2-bea9-c1b6-4c3e-1ae146286d89@cogentembedded.com>
References: <1502962386-6683-1-git-send-email-amelie.delaunay@st.com>
 <1502962386-6683-5-git-send-email-amelie.delaunay@st.com>
 <824d41f2-bea9-c1b6-4c3e-1ae146286d89@cogentembedded.com>
Message-ID: <b1aaf89c-33b5-d2db-73dd-89ad6c3a80c8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 08/17/2017 12:44 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 8/17/2017 12:33 PM, Amelie Delaunay wrote:
> 
>> This patch enables USB HS on stm32746g-eval (Host mode).
>>
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> ---
>>   arch/arm/boot/dts/stm32746g-eval.dts | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stm32746g-eval.dts 
>> b/arch/arm/boot/dts/stm32746g-eval.dts
>> index 69a9579..944501d 100644
>> --- a/arch/arm/boot/dts/stm32746g-eval.dts
>> +++ b/arch/arm/boot/dts/stm32746g-eval.dts
>> @@ -83,6 +83,13 @@
>>               gpios = <&gpioc 13 0>;
>>           };
>>       };
>> +
>> +    usbotg_hs_phy: usbphy {
> 
>     Name it "usb-phy" please, tpo be m,ore in line with the DT spec.
OK, will be fixed in v2. Thanks!
> 
> [...]
> 
> MBR, Sergei

Regards,
Amelie
