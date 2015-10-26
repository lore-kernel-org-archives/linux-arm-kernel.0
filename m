From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 26 Oct 2015 13:16:50 +0900
Subject: [PATCH v3 0/3] ARM: uniphier: add outer cache support and rework
 SMP operations
In-Reply-To: <CAK7LNATgK0OQbu_9J7DjUfDA_dKSCkCS4Kqw6vXD+=5oxkw4ig@mail.gmail.com>
References: <1442551054-2116-1-git-send-email-yamada.masahiro@socionext.com>
 <6239461.UGe6XP3dfB@wuerfel> <5275814.I392BfIEUH@wuerfel>
 <CAK7LNATgK0OQbu_9J7DjUfDA_dKSCkCS4Kqw6vXD+=5oxkw4ig@mail.gmail.com>
Message-ID: <CAK7LNASA-fmS943We9ncXUNQTa17s85OPmnWEdcY0yxTpW9hTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


2015-10-10 15:59 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi Arnd,
>
>
> 2015-10-06 15:22 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
>> On Tuesday 06 October 2015 16:20:23 Arnd Bergmann wrote:
>>> On Friday 18 September 2015 13:37:31 Masahiro Yamada wrote:
>>> > Hi Olof,
>>> >
>>> > Now Linux 4.3-rc1 is out, so I am back to this.
>>> >
>>> > 1/3: add outer cache support
>>> > 2/3: rework SMP operations
>>> > 3/3: add device tree nodes
>>> >
>>> > Because 2/3 highly depends on 1/3, I hope whole of this series
>>> > is applied through ARM-SOC tree.
>>>
>>> Sorry for the long delay here. Is this the latest version of these
>>> patches?
>>>
>>> Did Russell King review the first patch?
>>> Is he ok with merging this through arm-soc?
>>>
>>
>> I found an answer to the first question, as I see you posted
>> v5 of the patchset in the meantime.
>
>
> Yes, v5 is my latest version.
>
>
> For the second question, Russell gave me some comments on the 1/3
> and I answered.
>
> He mentioned nothing about merging the whole series thru arm-soc.
> (At least, he was not opposed to it, I guess)
>

Is it difficult to apply this series for the next merge window?
V5 is the latest.
No comment, but not applied.

Is there anything I can do but wait?



-- 
Best Regards
Masahiro Yamada
