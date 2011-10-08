From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 08 Oct 2011 14:14:27 +0530
Subject: [PATCH 00/24 V2] OMAP4: PM: suspend, CPU-hotplug and CPUilde
	support
In-Reply-To: <87vcs0ifgn.fsf@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>	<87d3e8juqm.fsf@ti.com>
	<87vcs0ifgn.fsf@ti.com>
Message-ID: <4E900D6B.5030006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 October 2011 04:20 AM, Kevin Hilman wrote:
> Kevin Hilman <khilman@ti.com> writes:
> 
>> Hi Santosh,
>>
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
>>> The series adds OMAP4 MPUSS (MPU SubSystem) power management support for
>>> suspend (S2R), CPU hotplug and CPUidle.
>>
>> Just noticed when doing some final build/sanity testing that there are a
>> few of compile/link warnings/problems when the kernel is built without
>> CONFIG_PM
>>
>> Some warnings:
>>
>> /work/kernel/omap/pm/arch/arm/mach-omap2/omap-wakeupgen.c:203:13: warning: 'irq_save_context' defined but not used
>> /work/kernel/omap/pm/arch/arm/mach-omap2/omap-wakeupgen.c:270:13: warning: 'irq_save_secure_context' defined but not used
>>
Sory I missed it in my builds.

[...]

> Please just cleanup the wakeupgen compile warnings and update your
> branch.
> 
Done !!
Updated branch : for_3_2/omap4-mpuss-pm_2

Regards
Santosh
