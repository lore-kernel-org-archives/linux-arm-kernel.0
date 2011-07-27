From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 27 Jul 2011 09:47:37 +0800
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <4E2F0176.1080403@codeaurora.org>
References: <201105181047.17309.arnd@arndb.de>
	<4E2F0176.1080403@codeaurora.org>
Message-ID: <CAGsJ_4wKdgSD1vEn5LeTnWjWWUcprMxsBV3NPgywqBbSsnVXiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/27 Stephen Boyd <sboyd@codeaurora.org>:
> On 05/18/2011 01:47 AM, Arnd Bergmann wrote:
>> This is the draft plan for maintaining the ARM subarchitectures in a common
>> tree, as a way to help coordinate the upstream merging of the
>> arch/arm/{plat,mach}-* changes into Linus' tree.
>>
> [snip]
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8fce5e6..942d052 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -630,6 +630,17 @@ S: ? ? ? Maintained
>> ?F: ? drivers/amba/
>> ?F: ? include/linux/amba/bus.h
>>
>> +ARM SUBARCHITECTURES
>> +M: ? Arnd Bergmann <arnd@arndb.de>
>> +M: ? Nicolas Pitre <nico@fluxnic.net>
>> +M: ? Thomas Gleixner <tglx@linutronix.de>
>> +M: ? arm at kernel.org
>> +L: ? linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>> +S: ? MAINTAINED
>> +F: ? arch/arm/mach-*/
>> +F: ? arch/arm/plat-*/
>> +T: ? git git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-subarch.git
>> +
>> ?ARM/ADI ROADRUNNER MACHINE SUPPORT
>> ?M: ? Lennert Buytenhek <kernel@wantstofly.org>
>> ?L: ? linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>
>
> Is this patch (or something similar) going to be merged now that the ARM
> SoC tree is up and running? Also, is the arm at kernel.org alias working?

yes. arm soc tree has been working and 3.1 window has pulled from Arnd
several times.

http://git.kernel.org/?p=linux/kernel/git/arm/linux-arm-soc.git;a=summary

>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
