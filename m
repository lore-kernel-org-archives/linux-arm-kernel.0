From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Sun, 17 Oct 2010 18:37:50 -0700
Subject: iwmmxt signal frame handling
In-Reply-To: <AANLkTinSJnjd9z4msto9j=gyOiuL2N4c7FOShB0fT1hA@mail.gmail.com>
References: <201010141609.10889.arnd@arndb.de>
	<AANLkTimHyhLRZwR-FRtciu+0sGYYFkAh4WfLCWwu59JA@mail.gmail.com>
	<AANLkTik3Brb-XbL1GkteVs_g9J3HtYsZMQogh+KR0LB0@mail.gmail.com>
	<201010151540.07982.arnd@arndb.de>
	<AANLkTinSJnjd9z4msto9j=gyOiuL2N4c7FOShB0fT1hA@mail.gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05984A27A8@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Eric Miao [mailto:eric.y.miao at gmail.com]
>Sent: 2010?10?15? 11:19 PM
>To: Arnd Bergmann
>Cc: linux-arm-kernel at lists.infradead.org; Peter Maydell; Russell King; Haojian Zhuang
>Subject: Re: iwmmxt signal frame handling
>
>On Fri, Oct 15, 2010 at 9:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 15 October 2010 15:32:04 Eric Miao wrote:
>>> > Acked-by: Eric Miao <eric.y.miao@gmail.com>
>>> >
>>>
>>> This also passes the internal iwmmxt test, Haojian please add your
>>> Tested-by please.
>>
>> Can you also confirm that the previous behaviour is broken?
>> If it is, the patch is probably a candidate for the stable trees.
>>
>
>I don't believe the previous behavior is going to cause any serious issue. The
>magic/size are only saved/restored only for those processes with
>TIF_USING_IWMMXT
>flag set. Yet this patch does seem to improve from security perspective by
>zero-ing the buffer.
>
>BTW: I didn't look too much into the code, but it seems to me that the aux can
>just be zero-ed in a whole?
>
>

Yes, the previous behavior doesn't cause serious issue on the testcases.

You can add "Test-by: Haojian Zhuang <haojian.zhuang@marvell.com>".

Thanks
Haojian
