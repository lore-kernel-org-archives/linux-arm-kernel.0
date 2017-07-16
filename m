From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 15 Jul 2017 19:36:21 -0700
Subject: [RFC 1/2] PM / suspend: Add platform_suspend_target_state()
In-Reply-To: <1703157.S2GHVxrQk4@aspire.rjw.lan>
References: <20170622085102.mpk7vxodpgxtrlfd@piout.net>
 <1578637.1XJQpJurXn@aspire.rjw.lan>
 <53f90d62-111f-57ae-907d-aa347b7033e0@free.fr>
 <1703157.S2GHVxrQk4@aspire.rjw.lan>
Message-ID: <e680f86a-88db-8a53-dca6-a79d120d480b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/15/2017 04:38 PM, Rafael J. Wysocki wrote:
> On Sunday, July 16, 2017 01:34:53 AM Mason wrote:
>> On 16/07/2017 01:24, Rafael J. Wysocki wrote:
>>
>>> On Saturday, July 15, 2017 10:20:27 AM Florian Fainelli wrote:
>>>
>>>> The enum offers the advantage of centralizing how many different states
>>>> exist for all the platforms we know about in the kernel, it's easy to
>>>> define common values for platforms that have the same semantics, just
>>>> like it's simple to add new values for platform specific details.
>>>
>>> Well, you seem to be liking this, so why don't you just implement it?
>>
>> At the end of his message, Florian wrote:
>>
>>> In any case, just agree and I will be happy to follow-up with patches.
> 
> But it may be hard to convince everybody without posting code changes
> and often enough showing a patch makes a good argument.

I had the patches ready last night, saw the emails this morning and
decided to go mountain bike for a bit to think about it some more. You
will find my follow-up patches that hopefully implement your recommendation.

Thanks
-- 
Florian
