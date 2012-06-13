From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 13 Jun 2012 18:48:54 +0200
Subject: [GIT PULL] at91: platform data for atmel-mci (for 3.5)
In-Reply-To: <4FCCD8D9.2070005@atmel.com>
References: <4FBE4FE7.3010005@atmel.com> <4FC722B7.10409@atmel.com>
 <CAOesGMhq8uzei+Dn8=1iYrTiAOtuByjm58j9zgFyORVG5VZuNQ@mail.gmail.com>
 <4FCCD8D9.2070005@atmel.com>
Message-ID: <4FD8C476.3080904@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2012 05:48 PM, Nicolas Ferre :
> On 05/31/2012 11:04 PM, Olof Johansson :
>> Hi Nicolas,
>>
>> On Thu, May 31, 2012 at 12:50 AM, Nicolas Ferre <nicolas.ferre@atmel.com
>> <mailto:nicolas.ferre@atmel.com>> wrote:
>>
>>     On 05/24/2012 05:12 PM, Nicolas Ferre :
>>     > Hi Arnd, hi Olof,
>>
>>     Ping?
>>
>>     (or maybe you will have a look at this after the merge window...)
>>
>>
>> So, I looked at this branch yesterday but I wasn't entirely happy with
>> the number of ifdefs it adds.
> 
> Unfortunately, this is the usual shape of any devices/boards files on
> AT91. This amount will be reduced when we remove the old driver and when
> we move newer/popular devices to Device Tree...
> 
>> If the idea is to deprecate the old driver, wouldn't it make more sense
>> to just cut everyone over instead of having both sets of setup in the
>> kernel?
> 
> Well, the old driver has existed since a very long time and I think that
> people are used to it on oldest platforms. This is why we put in place a
> overlapping period. This way we hope that the transition will be smoother.
> On the other hand, the old code will be removed in 3.7 so the
> overlapping period will not be so long.
> I hope that it will allow people to track bugs if some are remaining and
> switch to newer driver easily.

Olof, Arnd,

So, do you have made up your mind about this pull request?

Best regards,
-- 
Nicolas Ferre
