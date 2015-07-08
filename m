From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 8 Jul 2015 13:51:14 +0900
Subject: [PATCH 3/3] ARM: dts: UniPhier: add USB EHCI device nodes
In-Reply-To: <CAL_JsqJ_5SvSqfhtTYKmj9f2E0w0XLkekdOksDY2VZf7r6ZB+g@mail.gmail.com>
References: <1436154450-21102-1-git-send-email-yamada.masahiro@socionext.com>
 <1436154450-21102-4-git-send-email-yamada.masahiro@socionext.com>
 <CAL_JsqJ_5SvSqfhtTYKmj9f2E0w0XLkekdOksDY2VZf7r6ZB+g@mail.gmail.com>
Message-ID: <CAK7LNATGxa3mnU+rg-5+Eix8rvG-mB-A9SuTyCLHxvfHKOznNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


2015-07-07 23:53 GMT+09:00 Rob Herring <robherring2@gmail.com>:
> On Sun, Jul 5, 2015 at 10:47 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> Get USB 2.0 host controllers available with generic-ehci bindings.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>
>> diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
>> index 1261e6d..b042711 100644
>> --- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
>> +++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
>> @@ -127,6 +127,27 @@
>>                         reg = <0x59800000 0x2000>;
>>                 };
>>
>> +               usb0: usb at 5a800100 {
>> +                       compatible = "generic-ehci";
>
> You should also have a chip specific compatible string in addition to
> generic-ehci.

OK, will do.

I will wait a bit more before sending v2
in case someone might have some comments on this series.



-- 
Best Regards
Masahiro Yamada
