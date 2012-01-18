From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 16:26:23 +0000
Subject: [PATCH v2 3/3] ARM: Make the sched_clock framework mandatory
In-Reply-To: <1326903292-15794-4-git-send-email-marc.zyngier@arm.com>
References: <1326903292-15794-1-git-send-email-marc.zyngier@arm.com>
 <1326903292-15794-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120118162623.GL1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 04:14:52PM +0000, Marc Zyngier wrote:
>  obj-y		:= elf.o entry-armv.o entry-common.o irq.o opcodes.o \
>  		   process.o ptrace.o return_address.o setup.o signal.o \
> -		   sys_arm.o stacktrace.o time.o traps.o
> +		   sys_arm.o stacktrace.o time.o traps.o sched_clock.o

This list is supposed to be sorted alphabetically, but it seems to have
been forgotten when folk have patched it.
