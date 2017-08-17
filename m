From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 17 Aug 2017 16:46:12 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.14
In-Reply-To: <CAK8P3a1qY1UCVcFmmJ4Df=27xZqeEh91XZdW1udMSUNcb-ZeyA@mail.gmail.com>
References: <CAK7LNAQpsNrrrL2T8J1QYjA+9cmj8UO3JdTCZ7_WLGfdWC4G7w@mail.gmail.com>
 <CAK8P3a1qY1UCVcFmmJ4Df=27xZqeEh91XZdW1udMSUNcb-ZeyA@mail.gmail.com>
Message-ID: <CAK7LNAQSfsc7kqd76moygWFs0CNQLJtzuFTRu0Hsm6eKDEt5LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


2017-08-17 6:31 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Aug 16, 2017 at 5:00 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>
>> ----------------------------------------------------------------
>> UniPhier ARM SoC DT updates for v4.14
>>
>> - complete migrating to SPDX License Identifier
>> - remove support for old SoC
>> - add nodes for NAND, Audio pinctrl
>> - replace /include/ with #include
>>
>> ----------------------------------------------------------------
>> Katsuhiro Suzuki (1):
>>       ARM: dts: uniphier: add audio out pin-mux node
>>
>> Masahiro Yamada (4):
>>       ARM: dts: uniphier: use SPDX-License-Identifier (2nd)
>>       ARM: dts: uniphier: remove sLD3 SoC support
>>       ARM: dts: uniphier use #include instead of /include/
>>       ARM: dts: uniphier: add Denali NAND controller node
>
> Pulled into next/dt, but please clarify one question:
>
> How likely is it that there are still users of the sLD3 SoC on
> mainline kernels? The commit just states that it is too hard
> to maintain, but the more important question is whether anyone
> cares about it breaking.
>
>       Arnd


Nobody cared.

I tried to maintain it for completeness (then finally I gave up),
but nobody is using it.




-- 
Best Regards
Masahiro Yamada
