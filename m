From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Thu, 5 Jan 2017 09:08:19 +0100
Subject: [PATCH 05/22] ARM: dtsi: axp209: add AXP209 ADC subnode
In-Reply-To: <CAGb2v66dw=DECuHpLDzHnMP-O4UwZ+RkPsH0RofOGdBa7z7OHw@mail.gmail.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-6-quentin.schulz@free-electrons.com>
 <CAGb2v66dw=DECuHpLDzHnMP-O4UwZ+RkPsH0RofOGdBa7z7OHw@mail.gmail.com>
Message-ID: <1ddf7012-3336-84c2-6392-353b01beea93@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2017 06:51, Chen-Yu Tsai wrote:
> On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
>> X-Powers AXP209 PMIC has multiple ADCs, each one exposing data from the
>> different power supplies connected to the PMIC.
>>
>> This adds the ADC subnode for AXP20X PMIC.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/axp209.dtsi | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
>> index 675bb0f..2a4e8ee 100644
>> --- a/arch/arm/boot/dts/axp209.dtsi
>> +++ b/arch/arm/boot/dts/axp209.dtsi
>> @@ -53,6 +53,11 @@
>>         interrupt-controller;
>>         #interrupt-cells = <1>;
>>
>> +       axp209_adc: axp209_adc {
> 
> Node name should be generic. Please change it to "adc".
> 

OK, do I keep the label as is?

axp209_adc: adc {

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
