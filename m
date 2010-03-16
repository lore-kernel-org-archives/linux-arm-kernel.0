From: jason.wessel@windriver.com (Jason Wessel)
Date: Tue, 16 Mar 2010 13:52:09 -0500
Subject: [Kgdb-bugreport] [PATCH] ARM: change definition of cpu_relax()
	for ARM11MPCore
In-Reply-To: <000001cac52d$d13ff3f0$73bfdbd0$@deacon@arm.com>
References: <1268150768-6597-1-git-send-email-will.deacon@arm.com>	<20100309162202.GB17251@n2100.arm.linux.org.uk>	<000f01cabfa6$76951ac0$63bf5040$@deacon@arm.com>	<20100309164926.GC17251@n2100.arm.linux.org.uk>
	<001001cabfb2$4a75d2c0$df617840$@deacon@arm.com>
	<4B9817CF.2050807@windriver.com>
	<000001cac52d$d13ff3f0$73bfdbd0$@deacon@arm.com>
Message-ID: <4B9FD359.6040509@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/16/2010 12:26 PM, Will Deacon wrote:
> Hi Jason,
>
>   
> What's the status on this patch? Russell has applied the ARM SMP code to his
> tree now, so it would be good to get this patch into KGDB to avoid the deadlock
> on ARM11MPCore.
>
>   

Linux-next presently reflects the state of the outstanding pull request
I have to Linus.  I have yet to hear back any word as to what happened
with my pull request.

> I only ask because I can't see it in -next [although I see kgdb.c has moved!].
>   

It lives in kernel/debug/debug_core.c, assuming the code in linux-next
gets pulled into Linus's tree.  I already have an updated version of the
patch for the new structure, but not pushed to linux-next while my pull
request is in limbo.


Jason.
