From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 26 Jul 2011 19:23:12 -0700
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <CAGsJ_4wKdgSD1vEn5LeTnWjWWUcprMxsBV3NPgywqBbSsnVXiw@mail.gmail.com>
References: <201105181047.17309.arnd@arndb.de>
	<4E2F0176.1080403@codeaurora.org>
	<CAGsJ_4wKdgSD1vEn5LeTnWjWWUcprMxsBV3NPgywqBbSsnVXiw@mail.gmail.com>
Message-ID: <4E2F7690.6010008@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2011 06:47 PM, Barry Song wrote:
> 2011/7/27 Stephen Boyd <sboyd@codeaurora.org>:
>> On 05/18/2011 01:47 AM, Arnd Bergmann wrote:
>>> This is the draft plan for maintaining the ARM subarchitectures in a common
>>> tree, as a way to help coordinate the upstream merging of the
>>> arch/arm/{plat,mach}-* changes into Linus' tree.
>>>
>> [snip]
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 8fce5e6..942d052 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -630,6 +630,17 @@ S:       Maintained
>>>  F:   drivers/amba/
>>>  F:   include/linux/amba/bus.h
>>>
>>> +ARM SUBARCHITECTURES
>>> +M:   Arnd Bergmann <arnd@arndb.de>
>>> +M:   Nicolas Pitre <nico@fluxnic.net>
>>> +M:   Thomas Gleixner <tglx@linutronix.de>
>>> +M:   arm at kernel.org
>>> +L:   linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>> +S:   MAINTAINED
>>> +F:   arch/arm/mach-*/
>>> +F:   arch/arm/plat-*/
>>> +T:   git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-subarch.git
>>> +
>>>  ARM/ADI ROADRUNNER MACHINE SUPPORT
>>>  M:   Lennert Buytenhek <kernel@wantstofly.org>
>>>  L:   linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>>
>> Is this patch (or something similar) going to be merged now that the ARM
>> SoC tree is up and running? Also, is the arm at kernel.org alias working?
> yes. arm soc tree has been working and 3.1 window has pulled from Arnd
> several times.
>
> http://git.kernel.org/?p=linux/kernel/git/arm/linux-arm-soc.git;a=summary
>

That didn't really answer my questions, but thanks for pointing to the
arm-soc tree.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
