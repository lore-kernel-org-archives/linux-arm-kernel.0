From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 May 2012 09:51:50 +0100
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <4FAA34A9.5020708@gmail.com>
References: <4FAA34A9.5020708@gmail.com>
Message-ID: <20120511085150.GA17453@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bill,

On Wed, May 09, 2012 at 10:11:05AM +0100, bill4carson wrote:
> I'm using ARM11 MPCore on linux-2.6.34, unfortunately I have random
> panic/segment fault with task migration. I noticed a patch set
> [ARM11 MPCore: preemption/task migration cache coherency fixups] to fix
> such issues in here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-October/069851.html
> 
> It seems there is no follow ups, is there official patch to fix such
> issues?

Let's be honest: you haven't given us a lot to go on here. Perhaps you could
answer the following?

(1) Do you experience the same issues with a more recent kernel?
(2) If you apply the patches linked to above, does it fix your problem?
(3) If you can reproduce on current mainline, do you have a testcase?
(4) Does disabling CONFIG_PREEMPT make the problem disappear?

That should provide us with some information about the problem.

Thanks,

Will
