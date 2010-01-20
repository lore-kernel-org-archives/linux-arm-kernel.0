From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 20 Jan 2010 15:01:20 +0100
Subject: [PATCH/RFC v1 0/2] Human readable performance event
	description in sysfs
In-Reply-To: <20100120135553.GA22897@n2100.arm.linux.org.uk>
References: <1263978706-15499-1-git-send-email-t.fujak@samsung.com>
	<1263978999.4283.823.camel@laptop> <op.u6tslipz7p4s8u@pikus>
	<20100120133145.GE4089@wear.picochip.com>
	<1263994779.4283.1057.camel@laptop>
	<20100120135553.GA22897@n2100.arm.linux.org.uk>
Message-ID: <1263996080.4283.1064.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-01-20 at 13:55 +0000, Russell King - ARM Linux wrote:
> 
> Unfortunately, it isn't.  CPU identification has become a fairly murky
> business on ARM that the information exported from /proc/cpuinfo can
> no longer precisely identify the CPU itself.
> 
> For example, we just treat Cortex A8 and A9 as "ARMv7" because from the
> kernel's point of view, they're the same. 

Would it make sense to extend arm's cpuinfo to include enough
information so that userspace can indeed do this?

It seems to me userspace might care about the exact platform they're
running on.
