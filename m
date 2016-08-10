From: randy.li@rock-chips.com (Randy Li)
Date: Wed, 10 Aug 2016 09:12:35 +0800
Subject: [PATCH] ARM: dts: add rk3288-firefly-reload
In-Reply-To: <13761657.UM4fvlJBBq@diego>
References: <1549971.ctkvOGm2xW@diego>
 <CAFLEztTROearSEcgzV3EVHFcRcMQpLhAQ6BXP-dDyRDAWybaxg@mail.gmail.com>
 <C2BE77CA-A59B-4128-8802-E3E36FACDABA@rock-chips.com>
 <13761657.UM4fvlJBBq@diego>
Message-ID: <522097f6-8b5c-ee6d-c1b1-a63840228a0e@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/09/2016 06:58 PM, Heiko St?bner wrote:
> Am Dienstag, 9. August 2016, 18:06:33 schrieb Randy Li:
>> ??? iPad ??
>>
>>> ?? <jacobchen110@gmail.com> ? 2016?8?9? ??6:02 ???
>>>
>>> well?it has already been added....
>>>
>>> The root cause is not act8846. Firefly have a bug with sdmmc and it
>>> seems they didn't fix it in firefly-reload.
>>>
>>> http://bbs.t-firefly.com/forum.php?mod=viewthread&tid=256
> Thanks Jacob for pointing out this issue - I was always wondering why it
> wasn't working :-) .
>
>
>> Yes, Jacob is right. Those high speed options need the voltage down to 1.8v.
>> They should be removed.
> Randy, can you provide a follow-up patch that removes these excess properties
> please?
I will send a patch in weekend. I need some time to confirm whether
the sdio wifi would meet the same problem in firefly reload.
I found those patches are not been merged yet, should I just send
a new version or just a patch remove those incorrect excess properties?
>
>
> Thanks
> Heiko
>

-- 
Randy Li
The third produce department
