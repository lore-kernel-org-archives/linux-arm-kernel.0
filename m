From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 23 Jan 2017 21:25:16 +0200
Subject: [PATCH] ARM: OMAP2+: Remove duplicate definition of
 omap_test_timeout
In-Reply-To: <20170123150648.GP7403@atomide.com>
References: <20170120185151.1630-1-tony@atomide.com>
 <130610aa-ed1a-b363-fac5-6aaaf4d8e930@ti.com>
 <97761042-4a61-9abe-8b6f-a306936cb513@ti.com>
 <20170123150648.GP7403@atomide.com>
Message-ID: <5647a354-8abb-2cf8-3c52-8b930126968e@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/17 17:06, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170123 05:45]:
>> On 23/01/17 12:22, Lokesh Vutla wrote:
>>> + Tero,
>>>
>>> On Saturday 21 January 2017 12:21 AM, Tony Lindgren wrote:
>>>> We have the same defined already in common.h.
>>>
>>>
>>> This is reverting what has been introduced in this[1] series. Probably
>>> Tero can comment more here.
>>
>> Yeah, the point of introducing that was to get rid of common.h include from
>> the prcm files. See commit 250e27ee950bf67ceeb812eb4c8f2fea58d3e2b6.
>
> OK let's forget it for now then.

This work has been delayed by a great deal due to pending hwmod 
transition though....

Part of this may happen with the introduction of the genpd usage for 
clkdms/pwrdms actually.

-Tero
