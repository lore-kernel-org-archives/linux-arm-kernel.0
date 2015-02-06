From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 06 Feb 2015 14:29:39 +0100
Subject: [PATCH] MAINTAINERS: Add dts entries for mvebu and dove
In-Reply-To: <54D4BF09.2030708@lakedaemon.net>
References: <1423225810-5504-1-git-send-email-gregory.clement@free-electrons.com>
 <54D4BF09.2030708@lakedaemon.net>
Message-ID: <54D4C1C3.1010209@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason, Sebastian,

On 06/02/2015 14:18, Jason Cooper wrote:
> Hey Gregory,
> 
> On 2/6/15 7:30 AM, Gregory CLEMENT wrote:
>> Since many releases, the modifications of the mvebu device tree files
>> are merged through the mvebu subsystem. This patch makes it official
>> in order to help the contributors using the get_maintainer.pl to find
>> the accurate people.
>>
>> In the same time, updated the mvebu description which now includes the
>> kirkwood SoCs and new Armada SoCs.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>> Hi Jason, Andrew and Sebastian
>>
>> This last patch [1] showed that if people follow the recommendation to
>> submit patch (using get_maintainer.pl script), we don't receive
>> them. So I propose to amend MAINTAINERS with this patch.
>>
>> What do you think about it?
> 
> I had a patch somewhere to do similar, but since you seem to have this 
> in the top of your queue, let's go with this one.
> 
>>
>> If you agree then we can merged it in our next-merge windows (3.21).
>>
>> Thanks,
>>
>> Gregory
>>
>> [1]: http://thread.gmane.org/gmane.linux.drivers.devicetree/109387
>>
>>
>>
>>   MAINTAINERS | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5d9db6b445bc..d96daf53533c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1149,7 +1149,7 @@ ARM/MAGICIAN MACHINE SUPPORT
>>   M:	Philipp Zabel <philipp.zabel@gmail.com>
>>   S:	Maintained
>>
>> -ARM/Marvell Armada 370 and Armada XP SOC support
>> +ARM/Marvell Kirkwood and Armada 370, 375, 38x, XP SOC support
>>   M:	Jason Cooper <jason@lakedaemon.net>
>>   M:	Andrew Lunn <andrew@lunn.ch>
>>   M:	Gregory Clement <gregory.clement@free-electrons.com>
>> @@ -1158,6 +1158,8 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>>   S:	Maintained
>>   F:	arch/arm/mach-mvebu/
>>   F:	drivers/rtc/armada38x-rtc
>> +F:	arch/arm/boot/dts/armada*.dts
>> +F:	arch/arm/boot/dts/kirkwood*.dts
> 
> This doesn't match the dtsi's.  Maybe just kirkwood*, armada* ?

Yes we want also to match these files.

>>
>>   ARM/Marvell Berlin SoC support
>>   M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 
> It's just in the context, but I'm sure Sebastian wouldn't mind
> if we did berlin as well in this patch.

Sebastian,
if you agree I will add your entries, and rename the patch to

[PATCH] MAINTAINERS: Add dts entries for some of the Marvell Socs

> 
>> @@ -1175,6 +1177,7 @@ F:	arch/arm/mach-dove/
>>   F:	arch/arm/mach-mv78xx0/
>>   F:	arch/arm/mach-orion5x/
>>   F:	arch/arm/plat-orion/
>> +F:	arch/arm/boot/dts/dove*.dts
> 
> We should add orion5x here.  And same comment as above re matching.

OK. I am waiting for Sebastian agreement and then I will send
a new version.

Thanks,

Gregory



> 
> thx,
> 
> Jason.
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
