From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu, 8 Dec 2016 09:47:46 +0100
Subject: [PATCH v5 4/5] ARM: dts: Add I2C1 support for STM32429 eval board
In-Reply-To: <e61ae4d6-a65a-5cfa-6845-27351ac43af6@st.com>
References: <1481185563-8735-1-git-send-email-cedric.madianga@gmail.com>
 <1481185563-8735-5-git-send-email-cedric.madianga@gmail.com>
 <e61ae4d6-a65a-5cfa-6845-27351ac43af6@st.com>
Message-ID: <CAOAejn239D+R9AZuCVB8MChidAcQqWZvFzkkTTJF7s9UprzoaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,


2016-12-08 9:39 GMT+01:00 Alexandre Torgue <alexandre.torgue@st.com>:
> Hi Cedric,
>
> On 12/08/2016 09:26 AM, M'boumba Cedric Madianga wrote:
>>
>> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
>> ---
>>  arch/arm/boot/dts/stm32429i-eval.dts | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
> Can you change the commit header by: ARM: dts: stm32: Add I2C1 support for
> STM32429 eval board
Ok, I will use this typo in the next version

>
> thx
> Alex
>
>
>> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts
>> b/arch/arm/boot/dts/stm32429i-eval.dts
>> index afb90bc..74e0045 100644
>> --- a/arch/arm/boot/dts/stm32429i-eval.dts
>> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
>> @@ -141,3 +141,9 @@
>>         pinctrl-names = "default";
>>         status = "okay";
>>  };
>> +
>> +&i2c1 {
>> +       pinctrl-0 = <&i2c1_pins_b>;
>> +       pinctrl-names = "default";
>> +       status = "okay";
>> +};
>>
>
