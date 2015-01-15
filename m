From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 14 Jan 2015 17:52:51 -0800
Subject: [PATCH 1/2] MAINTAINERS: update brcmstb entries
In-Reply-To: <CAN8TOE_uHUFuyofTYFzWioB7TkCqx2sLYk2bbrV06EKOMvzYRg@mail.gmail.com>
References: <1414521895-12667-1-git-send-email-f.fainelli@gmail.com>	<1414521895-12667-2-git-send-email-f.fainelli@gmail.com>	<20141104204514.GA5908@quad.lixom.net>	<545957A5.6010802@gmail.com>	<CACxGe6s5rCUM_QQ-Da-AOKBbb4tUEJ_rcKU9frdEDDprYND3Tw@mail.gmail.com>	<54595FED.6000409@gmail.com>
 <CAN8TOE_uHUFuyofTYFzWioB7TkCqx2sLYk2bbrV06EKOMvzYRg@mail.gmail.com>
Message-ID: <54B71D73.1030800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/15 16:13, Brian Norris wrote:
> Since I found this in my inbox during garbage collection...
> 
> On Tue, Nov 4, 2014 at 3:23 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>> On 11/04/2014 02:56 PM, Grant Likely wrote:
>>> On Tue, Nov 4, 2014 at 10:48 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>> On 11/04/2014 12:45 PM, Olof Johansson wrote:
>>>>> On Tue, Oct 28, 2014 at 11:44:54AM -0700, Florian Fainelli wrote:
>>>>>> Remove Marc Carino from the brcmstb maintainers list and add Gregory
>>>>>> Fong and myself as new maintainers for the brcmstb platform.
>>>>>>
>>>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>>>> ---
>>>>>>  MAINTAINERS | 3 ++-
>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index dab92a78d1d5..33a8b31e03f0 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -2093,8 +2093,9 @@ F:     arch/arm/mach-bcm/bcm63xx.c
>>>>>>  F:  arch/arm/include/debug/bcm63xx.S
>>>>>>
>>>>>>  BROADCOM BCM7XXX ARM ARCHITECTURE
>>>>>> -M:  Marc Carino <marc.ceeeee@gmail.com>
>>>>>>  M:  Brian Norris <computersforpeace@gmail.com>
>>>>>> +M:  Gregory Fong <gregory.0xf0@gmail.com>
>>>>>> +M:  Florian Fainelli <f.fainelli@gmail.com>
>>>>>
>>>>> You're removing Marc here, but I don't see an ack from him, nor has
>>>>> he been cc:d on the patch. It's common practice for people to agree to
>>>>> being removed. Can you please make sure we get an ack from him on this,
>>>>> maybe by reposting and cc:ing him?
>>>>
>>>> Marc is no longer with Broadcom, do you still want him to ack this?
>>>
>>> Yes, absolutely. Maintainership is entrusted to an individual, not
>>> their employer. We've had many situations where someone has continued
>>> to maintain a platform even after changing employment. So, yes, there
>>> needs to be an ack from Marc.
>>
>> He is CC'd, now. Marc, please Ack this if you are okay with the change.
> 
> Can we add a "Not-nacked-by" tag and proceed? Marc is obviously not
> involved here any more. I figure removing expired maintainers should
> be a little easier than removing SCOTUS judges.

You'd think so right? How about this plan: unless Marc replies
otherwise, I submit a MAINTAINERS update removing him for the v3.21
kernel release?
-- 
Florian
