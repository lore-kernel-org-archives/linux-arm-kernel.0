From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Apr 2011 18:18:57 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110418135704.GB1765@opensource.wolfsonmicro.com>
References: <20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
	<BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
	<20110415155642.GO1611@n2100.arm.linux.org.uk>
	<BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
	<20110416082802.GS1611@n2100.arm.linux.org.uk>
	<20110416165725.GA25811@opensource.wolfsonmicro.com>
	<20110418081050.GG12272@atomide.com>
	<20110418135704.GB1765@opensource.wolfsonmicro.com>
Message-ID: <20110418171857.GC25671@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 02:57:04PM +0100, Mark Brown wrote:
> This does also come back to the whole thing about pointing at relevant
> work that people can do - we're not telling people the code they're
> submitting is problematic and they need to address things with it, we're
> saying that we're not even willing to look at the code or talk about
> things that would make it OK.  That's a really negative response that's
> essentially impossible to work with.

Linus has replied in this thread with his view, which is not much
different from the view which I've been stating all along.

I'll let you read Linus' message and see whether you can translate it
into a positive response for platform maintainers.

I had given up discussing it, as people haven't really been listening.
So, this will probably be my last message in this thread and on this
subject, and I've said what I'm going to do, and that's exactly what
I'm going to do.

I'm very sorry for people with new platforms outstanding like John Linn
who are on the sharp end of this (who have platform code ready to go)
but I see no solution at the moment.  It really is the case that either
I can say no to it, or I can put it in my tree and Linus will say no to
it.  So putting it in my tree *doesn't* help.

Will we ever be able to put John's code in the kernel?  Honestly, I have
no idea.  What I do know is that unless we start doing something to solve
the problem we have today with the quantity of code under arch/arm _and_
the constant churn of that code, we will _never_ be able to add new
platform support in any shape or form to the kernel.

If this means that people like Xilinx decide to drop their Linux kernel
effort, or decide not to bother submitting to mainline, then that's
unfortunate, but is not something I have any control over given the
situation we find ourselves in.
