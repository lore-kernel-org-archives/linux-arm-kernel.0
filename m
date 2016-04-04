From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 4 Apr 2016 18:12:30 +0300
Subject: [RFC PATCH] ARM: clocksource: make ARM_GLOBAL_TIMER selectable
In-Reply-To: <56EAB44D.7020902@linaro.org>
References: <1454610017-25499-1-git-send-email-grygorii.strashko@ti.com>
 <20160204224128.GG4215@xsjsorenbubuntu>
 <CAAtXAHcV-9gXcZOX8dzUOBZUwj9M=O4MAsMCJNQYAP+os-D7Tg@mail.gmail.com>
 <20160204233950.GH4215@xsjsorenbubuntu> <56D04D17.6030502@ti.com>
 <20160226152714.GD3173@xsjsorenbubuntu> <56DEAFB7.50105@ti.com>
 <56EAB44D.7020902@linaro.org>
Message-ID: <5702845E.90606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,
On 03/17/2016 03:42 PM, Daniel Lezcano wrote:
> On 03/08/2016 11:55 AM, Grygorii Strashko wrote:
>> Yeah. Thanks
>>
>> I'll re-send it after 4.6-rc.
>> But What I'm not fully understand is how to get it merged taking into 
>> account that
>> it touches few maches & clocksource :(
> 
> This is not a problem. Send it based on timers/core from the tip tree 
> and Cc the maintainers for the maches dir. As soon as they ack the 
> patches, I will merge it through my tree.
> 

I've rebased my patch on top of 4.6-rc2 and extended it on new mach
arch/arm/mach-artpec.

Then, as you've suggested, I've tried to apply it on top of 
kernel-tip/timers/core
kernel-tip := git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

but seems timers/core is obsolete (It doesn't contain arch/arm/mach-artpec yet).

Should I wait more or can resend it basing on top of  4.6-rc2?



-- 
regards,
-grygorii
