From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 01 Oct 2012 12:23:01 +0200
Subject: [GIT PULL] ARM: mvebu: cache-l2x0 DT for v3.7
In-Reply-To: <20121001000644.GG17765@titan.lakedaemon.net>
References: <20120930015012.GB17765@titan.lakedaemon.net>
 <20120930035503.GB477@quad.lixom.net>
 <20120930080136.GE6933@n2100.arm.linux.org.uk>
 <20121001000644.GG17765@titan.lakedaemon.net>
Message-ID: <50696F05.30003@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2012 02:06 AM, Jason Cooper wrote:
> Russell,
> 
> On Sun, Sep 30, 2012 at 09:01:36AM +0100, Russell King - ARM Linux wrote:
>> On Sat, Sep 29, 2012 at 08:55:03PM -0700, Olof Johansson wrote:
>>> On Sat, Sep 29, 2012 at 09:50:12PM -0400, Jason Cooper wrote:
>>>> Depends:
>>>>  - Based on arm-soc/late/kirkwood
>>>>  - Patches going through rmk's patch tracker:
>>>>     - arm: cache-l2x0: make outer_cache_fns a field of l2x0_of_data
>>>>     - arm: cache-l2x0: add an optional register to save/restore
>>>>     - arm: cache-l2x0: add support for Aurora L2 cache ctrl
>>>>
>>>>     - feature-use dependency only.  No build breakage or failed boot
>>>>       should occur.  Until patches from rmk's tracker land, driver
>>>>       won't know about compatible property, so it's like the driver
>>>>       isn't there.
>>>>
>>>> Adds:
>>>>  - cache-l2x0 DT entry for Marvell Armada (mvebu) SoCs
>>>
>>> Hi Jason,
>>>
>>> I'd prefer to hold off on this until we know that Russell is happy with
>>> the l2x0 changes, just in case this part of the series might need revising
>>> (i.e.  bindings changes). Please resend when he has picked them up!
>>
>> Well, there's no patches ever existing in the patch tracker with a
>> summary line as you list above - here are the last three containing
>> "l2x0":
>>
>>    7398/1  l2x0: only write to debug         3.4-rc3       20 Apr Applied 
>>            registers on PL310                              2012 
>>    7429/1  cache-l2x0: add a const qualifier 3.4           22 Jun Discarded 
>>                                                            2012 
>>    7507/1  cache-l2x0.c: save the final aux  3.6-rc4       03 Sep Applied 
>>            ctrl value for resuming                         2012 
>>
>> and it's probably now too late as I'm not going to be able to apply
>> any patches for the rest of the week, and as the -rc's have been
>> released over the weekend, we could see -final today.
> 
> Yes, I responded to Gregory (the author) in the thread with the patches
> asking him to push them into your tracker.   Unfortunately, he doesn't
> seem to be available.  So, yes, this is v3.8.

They are now in the patch tracker:

7545/1  ache-l2x0: make outer_cache_fns a field of l2x0_of_data
7546/1  cache-l2x0: add an optional register to save/restore
7547/1  cache-l2x0: add support for Aurora L2 cache ctrl


> 
> Once I see these first three patches make it in, I'll resubmit the
> pullrq.
> 
> thx,
> 
> Jason.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
