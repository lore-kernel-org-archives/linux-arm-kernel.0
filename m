From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 18 Jan 2012 16:29:00 +0000
Subject: [PATCH v2 3/3] ARM: Make the sched_clock framework mandatory
In-Reply-To: <20120118162623.GL1068@n2100.arm.linux.org.uk>
References: <1326903292-15794-1-git-send-email-marc.zyngier@arm.com>
 <1326903292-15794-4-git-send-email-marc.zyngier@arm.com>
 <20120118162623.GL1068@n2100.arm.linux.org.uk>
Message-ID: <4F16F34C.2020709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/12 16:26, Russell King - ARM Linux wrote:
> On Wed, Jan 18, 2012 at 04:14:52PM +0000, Marc Zyngier wrote:
>>  obj-y		:= elf.o entry-armv.o entry-common.o irq.o opcodes.o \
>>  		   process.o ptrace.o return_address.o setup.o signal.o \
>> -		   sys_arm.o stacktrace.o time.o traps.o
>> +		   sys_arm.o stacktrace.o time.o traps.o sched_clock.o
> 
> This list is supposed to be sorted alphabetically, but it seems to have
> been forgotten when folk have patched it.

Good point. I'll fix that on my next rebase.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
