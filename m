From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Nov 2010 10:41:04 -0000
Subject: ARM perf events spin locks
In-Reply-To: <20101130100802.GB4398@pulham.picochip.com>
References: <20101130100802.GB4398@pulham.picochip.com>
Message-ID: <004101cb907b$16f911b0$44eb3510$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Will,

Hello,

> I think we should convert the spinlocks in the ARM perf events code to raw
> spinlocks for realtime. Should we wait for your split set to get merged first
> before doing this?

Since this is a logically separate change, I think we're better off waiting
until the split stuff has been merged. As for the raw spinlocks, by realtime
do you mean PREEMPT_RT? Also, do we actually *need* raw spinlocks in the perf
code?

Will
