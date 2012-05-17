From: cjb@laptop.org (Chris Ball)
Date: Thu, 17 May 2012 14:36:47 -0400
Subject: [PATCH 2/2] mmc: at91-mci: this driver is now deprecated
In-Reply-To: <4FB54366.80409@atmel.com> (ludovic desroches's message of "Thu,
 17 May 2012 20:28:54 +0200")
References: <1337183519-25459-1-git-send-email-ludovic.desroches@atmel.com>
 <1337183519-25459-3-git-send-email-ludovic.desroches@atmel.com>
 <87k40b3ris.fsf@laptop.org> <4FB54366.80409@atmel.com>
Message-ID: <87pqa21wow.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 17 2012, ludovic.desroches wrote:
>>> +	  remove soon (for more information have a look to
>>            ^ removed
>>> +	  Documentation/feature-removal-schedule.txt). Please use
>>> +	  MMC_ATMEL_MCI.
>>>
>>>   	  If unsure, say N.
>
> Sorry for the typo, do you want a new patch or is ok?

It's okay, I've fixed it up here.

>> Seems like I should take this patch 2/2, and then someone else should
>> merge 1/2?
>
> Yes, Nicolas would probably take patch 2/2.

I think you must mean that Nicolas takes 1/2 (the arch/arm/ patches).
Assuming you do, that's fine and I've pushed 2/2 to mmc-next for 3.5 now.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
