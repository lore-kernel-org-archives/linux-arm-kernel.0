From: jian.hu@amlogic.com (Jian Hu)
Date: Wed, 11 Jul 2018 16:10:18 +0800
Subject: [PATCH 1/3] dt-bindings: clk: g12a: New binding for Meson-G12A SoC
In-Reply-To: <CAFBinCBJp1xzo-CNW1HU-Odhrug31yQ7c3khB+XwvsNXp5-gTA@mail.gmail.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-2-git-send-email-jian.hu@amlogic.com>
 <CAFBinCBJp1xzo-CNW1HU-Odhrug31yQ7c3khB+XwvsNXp5-gTA@mail.gmail.com>
Message-ID: <024e6d89-b60d-ba85-4d62-c3358e2cab6c@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/7/10 5:57, Martin Blumenstingl wrote:
> adding Rob Herring so it doesn't get lost on the devicetree mailing list
> 
> On Mon, Jul 9, 2018 at 1:13 PM Jian Hu <jian.hu@amlogic.com> wrote:
>>
>> Add new binding for Meson-G12A SoC Everything-Else part
>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
>> index e950599..0833006 100644
>> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
>> @@ -9,6 +9,7 @@ Required Properties:
>>                  "amlogic,gxbb-clkc" for GXBB SoC,
>>                  "amlogic,gxl-clkc" for GXL and GXM SoC,
>>                  "amlogic,axg-clkc" for AXG SoC.
>> +               "amlogic,g12a-clkc" for G12A SoC.
> should this be "amlogic,meson-g12a-clkc" instead?
> that would make it consistent with virtually all other bindings which
> use the schema "amlogic,meson<chip>-<ip-block>" (where chip is 8, 8b,
> 8m2, -gxbb, -gxl, ...)
> 
> see also: $ grep -R "amlogic," Documentation/devicetree/bindings/
> 
Which type should we choose,have a discussion?
.compatible = "amlogic,g12a-clkc or
.compatible = "amlogic,meson-g12a-clkc
>>
>>   - #clock-cells: should be 1.
>>
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-amlogic mailing list
>> linux-amlogic at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> .
> 
