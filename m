From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 4 Nov 2014 22:56:40 +0000
Subject: [PATCH 1/2] MAINTAINERS: update brcmstb entries
In-Reply-To: <545957A5.6010802@gmail.com>
References: <1414521895-12667-1-git-send-email-f.fainelli@gmail.com>
 <1414521895-12667-2-git-send-email-f.fainelli@gmail.com>
 <20141104204514.GA5908@quad.lixom.net> <545957A5.6010802@gmail.com>
Message-ID: <CACxGe6s5rCUM_QQ-Da-AOKBbb4tUEJ_rcKU9frdEDDprYND3Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 4, 2014 at 10:48 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 11/04/2014 12:45 PM, Olof Johansson wrote:
>> Hi,
>>
>> On Tue, Oct 28, 2014 at 11:44:54AM -0700, Florian Fainelli wrote:
>>> Remove Marc Carino from the brcmstb maintainers list and add Gregory
>>> Fong and myself as new maintainers for the brcmstb platform.
>>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>>  MAINTAINERS | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index dab92a78d1d5..33a8b31e03f0 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2093,8 +2093,9 @@ F:     arch/arm/mach-bcm/bcm63xx.c
>>>  F:  arch/arm/include/debug/bcm63xx.S
>>>
>>>  BROADCOM BCM7XXX ARM ARCHITECTURE
>>> -M:  Marc Carino <marc.ceeeee@gmail.com>
>>>  M:  Brian Norris <computersforpeace@gmail.com>
>>> +M:  Gregory Fong <gregory.0xf0@gmail.com>
>>> +M:  Florian Fainelli <f.fainelli@gmail.com>
>>
>> You're removing Marc here, but I don't see an ack from him, nor has
>> he been cc:d on the patch. It's common practice for people to agree to
>> being removed. Can you please make sure we get an ack from him on this,
>> maybe by reposting and cc:ing him?
>
> Marc is no longer with Broadcom, do you still want him to ack this?

Yes, absolutely. Maintainership is entrusted to an individual, not
their employer. We've had many situations where someone has continued
to maintain a platform even after changing employment. So, yes, there
needs to be an ack from Marc.

g.
