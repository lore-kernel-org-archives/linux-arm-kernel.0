From: tj@kernel.org (Tejun Heo)
Date: Wed, 24 Aug 2011 00:08:23 +0200
Subject: try_to_freeze() called with IRQs disabled on ARM
In-Reply-To: <20110823220056.GK3895@n2100.arm.linux.org.uk>
References: <20110823151936.GM9232@opensource.wolfsonmicro.com>
	<201108232351.55432.rjw@sisk.pl>
	<CAOS58YNUSn2eVLDLzqKmrtL7M5tSetkhZ1ODecLK54NSDnZVAA@mail.gmail.com>
	<20110823220056.GK3895@n2100.arm.linux.org.uk>
Message-ID: <CAOS58YNuCbaOsWBfmjSUsXsArZ5ng6c0B30yswFbRAWkho6L6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 12:00 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> How does that solve it? ?IRQs disabled from assembly, which doesn't touch
> the preempt counter.

Then test something else, be it the IRQ mask bit or some other context.

-- 
tejun
