From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 8 Jan 2018 14:44:25 +0800
Subject: [PATCH v2 3/5] ARM64: dts: meson-axg: uart: Add the pinctrl info
 description
In-Reply-To: <b2571e30-d543-9288-68cf-1af86bb5f4bc@amlogic.com>
References: <20180106001044.108163-1-yixun.lan@amlogic.com>
 <20180106001044.108163-4-yixun.lan@amlogic.com>
 <CAFBinCCuQ-NK747+GHDkhZty_UMMgzCYOYFcNTrRDJgU8OM=Gw@mail.gmail.com>
 <b2571e30-d543-9288-68cf-1af86bb5f4bc@amlogic.com>
Message-ID: <882732bb-952c-ca90-1776-a9da294456f6@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Martin:

On 01/08/18 14:07, Yixun Lan wrote:
> Hi Martin
> 
> On 01/08/18 04:19, Martin Blumenstingl wrote:
>> Hi Yixun,
>>
>> On Sat, Jan 6, 2018 at 1:10 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
>>> Describe the pinctrl info for the UART controller which is found
>>> in the Meson-AXG SoCs.
>>>
>>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>>> ---
>>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 97 ++++++++++++++++++++++++++++++
>>>  1 file changed, 97 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>>> index 644d0f9eaf8c..1eb45781c850 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
>>> @@ -448,6 +448,70 @@
>>>                                                 function = "spi1";
>>>                                         };

.

>>>
>>> +
>> did you add this additional newline on purpose?
oops, this is added by mistake..
thanks for catching this, I will fix it

>>>                                 remote_input_ao_pins: remote_input_ao {
>>>                                         mux {
>>>                                                 groups = "remote_input_ao";
>>>                                                 function = "remote_input_ao";
>>>                                         };
>>>                                 };
>>> +
>>> +                               uart_ao_a_pins: uart_ao_a {
>>> +                                       mux {
>>> +                                               groups = "uart_ao_tx_a",
>>> +                                                       "uart_ao_rx_a";
>>> +                                               function = "uart_ao_a";
>>> +                                       };
>>> +                               };
>>> +
>>> +                               uart_ao_a_cts_rts_pins: uart_ao_a_cts_rts {
>>> +                                       mux {
>>> +                                               groups = "uart_ao_cts_a",
>>> +                                                       "uart_ao_rts_a";
>>> +                                               function = "uart_ao_a";
>>> +                                       };
>>> +                               };
>>> +
>>> +                               uart_ao_b_pins: uart_ao_b {
>>> +                                       mux {
>>> +                                               groups = "uart_ao_tx_b",
>>> +                                                       "uart_ao_rx_b";
>>> +                                               function = "uart_ao_b";
>>> +                                       };
>>> +                               };
>>> +
>>> +                               uart_ao_b_cts_rts_pins: uart_ao_b_cts_rts {
>>> +                                       mux {
>>> +                                               groups = "uart_ao_cts_b",
>>> +                                                       "uart_ao_rts_b";
>>> +                                               function = "uart_ao_b";
>>> +                                       };
>>> +                               };
>>>                         };
>>>
>>>                         pwm_AO_ab: pwm at 7000 {
>>> --
>>> 2.15.1
>>>
>>>
>>> _______________________________________________
>>> linux-amlogic mailing list
>>> linux-amlogic at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
>>
>> Regards
>> Martin
>>
>> .
>>
> .
> 
