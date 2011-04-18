From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 18 Apr 2011 21:23:02 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110418171857.GC25671@n2100.arm.linux.org.uk>
References: <20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
	<BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
	<20110415155642.GO1611@n2100.arm.linux.org.uk>
	<BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
	<20110416082802.GS1611@n2100.arm.linux.org.uk>
	<20110416165725.GA25811@opensource.wolfsonmicro.com>
	<20110418081050.GG12272@atomide.com>
	<20110418135704.GB1765@opensource.wolfsonmicro.com>
	<20110418171857.GC25671@n2100.arm.linux.org.uk>
Message-ID: <20110418202301.GA13808@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 06:18:57PM +0100, Russell King - ARM Linux wrote:

> Linus has replied in this thread with his view, which is not much
> different from the view which I've been stating all along.

Yeah, I saw that.  Quite frankly it's astonishing - I must apologise, I
had thought you were most likely misinterpreting what he was saying.

> Will we ever be able to put John's code in the kernel?  Honestly, I have
> no idea.  What I do know is that unless we start doing something to solve
> the problem we have today with the quantity of code under arch/arm _and_
> the constant churn of that code, we will _never_ be able to add new
> platform support in any shape or form to the kernel.

Given where we're at right now I'm guessing we're going to see ARM
development halted until at least the merge window after next which is
5-6 months or so.  We're not talking about trivial bits of
infrastructure here and obviously any substantial reworks here are going
to involve churn anyway.

To make matters worse unless people just give up the longer we keep the
tree shut down the larger the merge will be when it does reopen.
