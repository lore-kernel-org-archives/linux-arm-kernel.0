From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 Apr 2011 09:28:02 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
	<BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
	<20110415155642.GO1611@n2100.arm.linux.org.uk>
	<BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
Message-ID: <20110416082802.GS1611@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 10:10:04AM -0600, Grant Likely wrote:
> On Fri, Apr 15, 2011 at 9:56 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Apr 15, 2011 at 09:12:39AM -0600, Grant Likely wrote:
> >> For example, John Linn
> >> has posted support for the new Xilinx ARM FPGA platform, has been
> >> through several rounds of review, but now he fears that it will all be
> >> rejected and he'll have to start over in 3 months.
> >
> > Well, what about my fear that we won't be able to get anything more
> > past Linus if we submit another 60k lines of code during the next
> > merge window?
> 
> Worst he can say is no.  He /knows/ we're trying to fix the problem.
> He also knows that development doesn't stop, even in the midst of
> consolidation work that is going to take a lot of time.

I find that I can't agree with your point of view on this - I asked
Linus for his view on the message which started this thread.

Linus' big concern is the platform stuff, and he is close to refusing
to pull various git trees if he thinks people haven't taken his concern
on board.

As a result of that, I'm going to modify my position to be: bug fixes,
regression fixes, consolidation, and core code features.

Towards the end of the cycle, we may be able to consider some platforms,
but _only_ if they make use of the consolidated features and therefore
have _minimal_ additional code.
