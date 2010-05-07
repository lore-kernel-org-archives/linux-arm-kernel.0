From: will.deacon@arm.com (Will Deacon)
Date: Fri, 7 May 2010 19:04:16 +0100
Subject: MSM PMU Support in Commit ee3c454b
In-Reply-To: <1273252359.3542.21.camel@c-dwalke-linux.qualcomm.com>
References: <000101caee07$104acdc0$30e06940$@deacon@arm.com>
	<1273252359.3542.21.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <000201caee0f$b55a6200$200f2600$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thanks for the quick reply.

> Oh, sorry about that. I didn't realize a change like that was pending.
> When are you planning to merge these changes?

I've put them in the patch system recently and Russell has been merging
them since then.
 
> > I can update the patch in the patch system so it applies cleanly, but
> > the mach-msm bsp will need updating to register the IRQ using the new
> > mechanism. Daniel: would you like me to submit a patch to do this, or
> > would you rather do it [since I'm unfamiliar with the mach]?
> 
> Either, but your more motivated as it's blocking your progress ..

I just posted a patch to the list. I've also superseded the outstanding PMU
registration patch on the patch system with 6113/1 so that it applies cleanly
to Russell's devel branch.

Will
