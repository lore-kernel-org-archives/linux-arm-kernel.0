From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 21 May 2012 12:19:49 +0200
Subject: [PATCH 2/2] mmc: at91-mci: this driver is now deprecated
In-Reply-To: <87pqa21wow.fsf@laptop.org>
References: <1337183519-25459-1-git-send-email-ludovic.desroches@atmel.com>
 <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
 <87k40b3ris.fsf@laptop.org> <4FB54366.80409@atmel.com>
 <87pqa21wow.fsf@laptop.org>
Message-ID: <4FBA16C5.30206@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2012 08:36 PM, Chris Ball :
> Hi,
> 
> On Thu, May 17 2012, ludovic.desroches wrote:
>>>> +	  remove soon (for more information have a look to
>>>            ^ removed
>>>> +	  Documentation/feature-removal-schedule.txt). Please use
>>>> +	  MMC_ATMEL_MCI.
>>>>
>>>>   	  If unsure, say N.
>>
>> Sorry for the typo, do you want a new patch or is ok?
> 
> It's okay, I've fixed it up here.
> 
>>> Seems like I should take this patch 2/2, and then someone else should
>>> merge 1/2?
>>
>> Yes, Nicolas would probably take patch 2/2.
> 
> I think you must mean that Nicolas takes 1/2 (the arch/arm/ patches).
> Assuming you do, that's fine and I've pushed 2/2 to mmc-next for 3.5 now.

Ludovic and Chris,

Sure, I will take 1/2 patch of this series through arm-soc.
Unfortunately, it seems to be a bit late for 3.5...

Anyway, I will talk with Arnd and Olof about the possibility to include
it in a "late" or "staging" branch: that will allow this platform data
addition to have some exposure in linux-next.
We can also imagine that having a better support for atmel-mci driver in
AT91 boards will help people gain a more stable system and avoid using a
now "deprecated" driver that will be removed in 3.7. So I am personally
in favor for an inclusion as soon as possible...

Thanks, best regards,
-- 
Nicolas Ferre
