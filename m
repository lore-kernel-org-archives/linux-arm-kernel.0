From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Mon, 18 May 2015 12:17:43 +0200
Subject: ARM: STM32: undefined ARMV7M_SYSTICK
In-Reply-To: <CALszF6DytW-KneB78V8VzTGnJYmAxN4h-46A+GkzooC32dj40Q@mail.gmail.com>
References: <CAD3Xx4+0mgWskGcdJPv7wL9QctTwz1Hz4paoHjpgWKjGpeOA8g@mail.gmail.com>
 <CALszF6DytW-KneB78V8VzTGnJYmAxN4h-46A+GkzooC32dj40Q@mail.gmail.com>
Message-ID: <CALszF6B7ncJFJSLBLOH+ppFtVw4Cc0ZR95TRPK=2kGb1Lvg0jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-18 12:16 GMT+02:00 Maxime Coquelin <mcoquelin.stm32@gmail.com>:
> Hi Valentin,
>
> 2015-05-18 11:30 GMT+02:00 Valentin Rothberg <valentinrothberg@gmail.com>:
>> Hi Maxime,
>>
>> your commit 9b799b78372c ("ARM: Add STM32 family machine") is in
>> today's linux-next tree (i.e., next-20150518) adding the following
>> Kconfig select:
>>
>> +config ARCH_STM32
>> [...]
>> +       select ARMV7M_SYSTICK
>>
>> ARMV7M_SYSTICK is not defined in Kconfig, so that the select turns out
>> to be a NOP.  Is there a patch queued somewhere that adds this Kconfig
>> option?
>
> Yes, this Kconfig option is added by another patch[0].
> I expect this patch to be taken by clocksource maintainers for v4.2.
>
>>
>> I detected this issue with scripts/checkkconfigsymbols.py by diffing
>> yesterday's and today's linux-next tree.  You can also use the script
>> to check specific commits for Kconfig related issues.
> Ok. Thanks for the hint.
>
> Kind regards,
> Maxime
>
>>
>> Kind regards,
>>  Valentin
>

Sorry, with correct link:

https://lkml.org/lkml/2015/5/9/47

Kind regards,
Maxime
