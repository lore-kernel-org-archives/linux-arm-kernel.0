From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 07 Dec 2013 21:07:15 +0100
Subject: [PATCH] rtc: pxa: drop usage of CLOCK_TICK_RATE
In-Reply-To: <52954A3D.3040108@gmail.com> (Haojian Zhuang's message of "Wed,
 27 Nov 2013 09:26:21 +0800")
References: <1383942318-12569-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131126133731.GE28642@pengutronix.de> <52954A3D.3040108@gmail.com>
Message-ID: <87mwkc77d8.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

> On 11/26/2013 09:37 PM, Uwe Kleine-K?nig wrote:
>> Hello,
>>
>> [Cc: += akpm]
>>
>> On Fri, Nov 08, 2013 at 09:25:18PM +0100, Uwe Kleine-K?nig wrote:
>>> The symbol CLOCK_TICK_RATE is (at least on ARM) defined in an platform
>>> specific header <mach/timex.h>. There are plans to stop using and kill
>>> these platform specific headers. So fix the only user of pxa's
n>>> <mach/timex.h> to not use it.
>>>
>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> Who is looking for this patch?
>>
>> Best regards
>> Uwe
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>
> I think that Alessandro could help to merge.
>
> Alessandro,
> Is it right?

Why won't you just remove TIMER_FREQ all together instead ?
I don't remember why I put that in, but looking back at it, I don't find any
use, so why don't we remove the line ?

Cheers.

--
Robert
