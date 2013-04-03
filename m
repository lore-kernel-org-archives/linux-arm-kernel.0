From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 03 Apr 2013 07:39:41 -0400
Subject: [Suggestion] ARM64:kernel: compiling issue for early_console.
In-Reply-To: <515BE49C.8040601@asianux.com>
References: <5152DB83.8080703@asianux.com>
 <20130327115509.GA1603@MacBook-Pro.local> <5152DFF1.2090000@asianux.com>
 <515BE49C.8040601@asianux.com>
Message-ID: <515C14FD.4040703@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen,

On 04/03/2013 04:13 AM, Chen Gang wrote:
> Hello Maintainers:
> 
>   it seems, this issue still exists in next-20130402.
> 
>   have you already fixed it in another tree ?

Maybe somebody else does have a fix, but Catalin mentioned he was going on
vacation for two weeks on March 28th in "[GIT PULL] Preparatory GIC patches
for arm64 support".

>   if really no one fix it within this week, I should try (since I find it).

I'm sure a fix would be appreciated.

> On 2013?03?27? 20:02, Chen Gang wrote:
>> On 2013?03?27? 19:55, Catalin Marinas wrote:
>>> On Wed, Mar 27, 2013 at 11:44:03AM +0000, Chen Gang wrote:
>>>>>   the error message:
>>>>>     arch/arm64/kernel/early_printk.c: At top level:
>>>>>     arch/arm64/kernel/early_printk.c:98:23: error: conflicting types for ?early_console?
>>>>>     In file included from arch/arm64/kernel/early_printk.c:20:0:
>>>>>     include/linux/console.h:145:24: note: previous declaration of ?early_console? was here
>>>>>     make[1]: *** [arch/arm64/kernel/early_printk.o] Error 1
>>>>>     make: *** [arch/arm64/kernel] Error 2
>>> Is this in linux-next? Mainline seems fine.
>>
>>   yes, it is in next-20130326 at least :-)
>>
>>>
>>> I saw some patches from tglx on unifying the various early printk
>>> implementations, though not sure whether it's those patches causing it
>>> (in which case arm64 needs to be updated as well).

I looked briefly and wasn't able to find this patchset.

Regards,
Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
