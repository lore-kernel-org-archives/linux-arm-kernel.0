From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 12 Apr 2011 01:25:17 -0700
Subject: [FAILED] BLD i.MX51 Referenz + linux-next git kernel
In-Reply-To: <20110408211136.GC18601@pengutronix.de>
References: <E1Q8IiX-0006uC-GW@himalia.hi.pengutronix.de>
	<20110408211136.GC18601@pengutronix.de>
Message-ID: <4DA40C6D.3070302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/8/2011 2:11 PM, Uwe Kleine-K?nig wrote:
> Hello,
>
> I haven't looked yet (and won't anymore today), but our autobuilder
> failed to build because of something that looks like a arm global
> problem.
>
> On Fri, Apr 08, 2011 at 10:55:45PM +0200, Pengutronix Sisyphus Druid wrote:
>>                               Source URL .... git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git
>>                     Kernel configuration .... use config: mx51_defconfig
>> [...]
>>   CC      arch/arm/kernel/process.o
>> arch/arm/kernel/process.c: In function 'cpu_idle':
>> arch/arm/kernel/process.c:200: error: implicit declaration of function 'cpuidle_call_idle'
>> make[1]: *** [arch/arm/kernel/process.o] Error 1
>> make: *** [arch/arm/kernel] Error 2
>> make: *** Waiting for unfinished jobs....
> Will look into that on Monday if nobody else cares before.

https://lkml.org/lkml/2011/4/4/109 should fix it.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
