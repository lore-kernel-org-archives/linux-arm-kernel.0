From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 06 Aug 2014 17:43:38 +0200
Subject: CPUIdle Armada 370
In-Reply-To: <53E249A1.900@free-electrons.com>
References: <1407333701627.99622@vitec.com>
 <53E24654.6020008@free-electrons.com> <53E249A1.900@free-electrons.com>
Message-ID: <53E24D2A.50706@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

[..]

>> On 06/08/2014 16:01, Nicolas Derouineau wrote:
>>> Hello,
>>> I am currently trying to use the CPUIdle driver provided by linux-next (or by the patch here https://github.com/MISL-EBU-System-SW/mainline-public/commits/3.16/cpuidle-v3). 
>>
>> I have just tested using next-20140806 and mvebu_v7_defconfig.
>> And it worked well on a mirabox using the Armada 370 SoC.
>>
>>>
>>> Everything runs fine as long as I don't select the CPU driver for the ARMADA Family. When I do, at boottime, the program is entering the __cpu_suspend save function and then get lost in it and that turns into a kernel panic. I have already made a post about this on the ARM Community Forum (http://community.arm.com/thread/6326).
>>>
>>> The "faulty" configuration file is attached to this email.
>>
>> Now I will try with this configuration
> 
> Using your configuration file I didn't reproduce your issue.
> And according to the stat given by linux the kernel spent a lot
> of time in idle:
> 
> cat /sys/devices/system/cpu/cpu0/cpuidle/state1/time
> 338822284
> 
> 
> Could you try again with next-20140806?

Also could you send your full boot log until the crash
it may help us.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
