From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 12 Aug 2015 22:14:18 +0900
Subject: [PATCH 3/3] ARM: dts: UniPhier: add ProXstream2 and PH1-LD6b
 SoC/board support
In-Reply-To: <20150811130739.GD30181@localhost>
References: <1438687264-26538-1-git-send-email-yamada.masahiro@socionext.com>
 <1438687264-26538-4-git-send-email-yamada.masahiro@socionext.com>
 <20150811130739.GD30181@localhost>
Message-ID: <CAK7LNAQ+6tQ9Ci6LKsAB7kLj0o60Hizo2gOokDH9qW=FnO0gEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,


2015-08-11 22:07 GMT+09:00 Olof Johansson <olof@lixom.net>:
> Hi,
>
> On Tue, Aug 04, 2015 at 08:21:04PM +0900, Masahiro Yamada wrote:
>> Initial version of DTSI for ProXstream2 and PH1-LD6b and DTS for
>> PH1-LD6b reference board.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  arch/arm/boot/dts/Makefile                  |   3 +-
>>  arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts | 105 +++++++++++
>>  arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi    |  67 +++++++
>>  arch/arm/boot/dts/uniphier-proxstream2.dtsi | 273 ++++++++++++++++++++++++++++
>>  4 files changed, 447 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld6b-ref.dts
>>  create mode 100644 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi
>>  create mode 100644 arch/arm/boot/dts/uniphier-proxstream2.dtsi
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 246473a..6eb3f2f 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -645,7 +645,8 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
>>       uniphier-ph1-sld3-ref.dtb \
>>       uniphier-ph1-ld4-ref.dtb \
>>       uniphier-ph1-pro4-ref.dtb \
>> -     uniphier-ph1-sld8-ref.dtb
>> +     uniphier-ph1-sld8-ref.dtb \
>> +     uniphier-ph1-ld6b-ref.dtb
>
> Please always add entries here sorted, don't just append. I've fixed it
> up for you this time.
>
>

Please do not do that (without my ack).

It was already sorted from old SoC to new SoC.

Sorting chronologically (in other words, in the order of chip ID)
makes more sense than sorting alphabetically.



-- 
Best Regards
Masahiro Yamada
