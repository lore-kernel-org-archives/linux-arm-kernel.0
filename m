From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 26 Feb 2015 19:13:57 +0100
Subject: [PATCH v2] MAINTAINERS: Add dts entries for some of the Marvell
 SoCs
In-Reply-To: <54EF5922.2040701@lakedaemon.net>
References: <1423237058-25431-1-git-send-email-gregory.clement@free-electrons.com>
 <54EF57AF.7070000@free-electrons.com> <54EF5922.2040701@lakedaemon.net>
Message-ID: <54EF6265.6010807@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,
On 26/02/2015 18:34, Jason Cooper wrote:
> Gregory,
> 
> On 2/26/15 12:28 PM, Gregory CLEMENT wrote:
>> Hi all,
>>
>> Who should take the following patch?
>>
>> Should I apply it on the mvebu tree?
> 
> No, this is a conflict-ridden file.  Please resend and include 
> 'arm at kernel.org' to the recipients.  Then ask Arnd or Olof to pick it up 
> directly.

Thanks for the advice, I will do it.

Gregory

> 
> thx,
> 
> Jason.
> 
>>
>> Thanks,
>>
>> Gregory
>>
>>
>> On 06/02/2015 16:37, Gregory CLEMENT wrote:
>>> Since many releases, the modifications of the mvebu and berlin device
>>> tree files are merged through the mvebu subsystem. This patch makes it
>>> official in order to help the contributors using the get_maintainer.pl
>>> to find the accurate peoples.
>>>
>>> In the same time, updated the mvebu description which now includes the
>>> kirkwood SoCs and new Armada SoCs.
>>>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>> Acked-by: Jason Cooper <jason@lakedaemon.net>
>>> Acked-by: Andrew Lunn <andrew@lunn.ch>
>>> ---
>>>   MAINTAINERS | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 5d9db6b445bc..dba52f8597e2 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1149,7 +1149,7 @@ ARM/MAGICIAN MACHINE SUPPORT
>>>   M:	Philipp Zabel <philipp.zabel@gmail.com>
>>>   S:	Maintained
>>>
>>> -ARM/Marvell Armada 370 and Armada XP SOC support
>>> +ARM/Marvell Kirkwood and Armada 370, 375, 38x, XP SOC support
>>>   M:	Jason Cooper <jason@lakedaemon.net>
>>>   M:	Andrew Lunn <andrew@lunn.ch>
>>>   M:	Gregory Clement <gregory.clement@free-electrons.com>
>>> @@ -1158,12 +1158,15 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>>   S:	Maintained
>>>   F:	arch/arm/mach-mvebu/
>>>   F:	drivers/rtc/armada38x-rtc
>>> +F:	arch/arm/boot/dts/armada*
>>> +F:	arch/arm/boot/dts/kirkwood*
>>>
>>>   ARM/Marvell Berlin SoC support
>>>   M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>>   L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>>   S:	Maintained
>>>   F:	arch/arm/mach-berlin/
>>> +F:	arch/arm/boot/dts/berlin*
>>>
>>>   ARM/Marvell Dove/MV78xx0/Orion SOC support
>>>   M:	Jason Cooper <jason@lakedaemon.net>
>>> @@ -1175,6 +1178,8 @@ F:	arch/arm/mach-dove/
>>>   F:	arch/arm/mach-mv78xx0/
>>>   F:	arch/arm/mach-orion5x/
>>>   F:	arch/arm/plat-orion/
>>> +F:	arch/arm/boot/dts/dove*
>>> +F:	arch/arm/boot/dts/orion5x*
>>>
>>>   ARM/Orion SoC/Technologic Systems TS-78xx platform support
>>>   M:	Alexander Clouter <alex@digriz.org.uk>
>>>
>>
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
