From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 26 Sep 2014 19:08:45 +0200
Subject: [PATCH v3 4/4] arm: pxa: add non device-tree timer link to
 clocksource
In-Reply-To: <54251B27.909@linaro.org> (Daniel Lezcano's message of "Fri, 26
 Sep 2014 09:52:07 +0200")
References: <1405356724-32207-1-git-send-email-robert.jarzmik@free.fr>
 <1405356724-32207-4-git-send-email-robert.jarzmik@free.fr>
 <53CD25A4.7030606@linaro.org> <87oawivarv.fsf@free.fr>
 <54251B27.909@linaro.org>
Message-ID: <87lhp6paw2.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 07/21/2014 08:15 PM, Robert Jarzmik wrote:
>> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
>>
>>> On 07/14/2014 06:52 PM, Robert Jarzmik wrote:
>>>> As clocksource pxa_timer was moved to clocksource framework, the
>>>> pxa_timer initialization needs to be a bit amended, to pass the
>>>> necessary informations to clocksource, ie :
>>>>    - the timer interrupt (mach specific)
>>>>    - the timer registers base (ditto)
>>>>    - the timer clockrate
>>>>
>>>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>>>
>>>> ---
>>>> Since V2: Arnd's comment : moved extern declaration into .h file
>>>> ---
>>>

> Hi,
>
> May be I missed it but I don't see the Haojian's ack.
>
> Thanks
>   -- Daniel

You're right, I scanned through my mail and didn't find the ack.
Haojian, would you review this one please ?

It's here :
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272311.html

Cheers.

-- 
Robert
