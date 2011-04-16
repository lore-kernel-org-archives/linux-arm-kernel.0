From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 16 Apr 2011 17:57:26 +0100
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110416082802.GS1611@n2100.arm.linux.org.uk>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<20110414110854.GF29938@atomide.com>
	<20110414120209.GG1611@n2100.arm.linux.org.uk>
	<20110414123126.GA3336@atomide.com>
	<BANLkTi=3+yQU_URj0Tao_MP7v=O7cO_ftg@mail.gmail.com>
	<20110415155642.GO1611@n2100.arm.linux.org.uk>
	<BANLkTi=iqcwq+kEaDEWGrCAutZUAPPXFyw@mail.gmail.com>
	<20110416082802.GS1611@n2100.arm.linux.org.uk>
Message-ID: <20110416165725.GA25811@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 16, 2011 at 09:28:02AM +0100, Russell King - ARM Linux wrote:
> On Fri, Apr 15, 2011 at 10:10:04AM -0600, Grant Likely wrote:

> > Worst he can say is no.  He /knows/ we're trying to fix the problem.
> > He also knows that development doesn't stop, even in the midst of
> > consolidation work that is going to take a lot of time.

> I find that I can't agree with your point of view on this - I asked
> Linus for his view on the message which started this thread.

It'd be interesting to read what he wrote there.

> Linus' big concern is the platform stuff, and he is close to refusing
> to pull various git trees if he thinks people haven't taken his concern
> on board.

Right, and the discussion here is essentially about if that can be done
without also blocking development.  But ignoring that for the moment...

> Towards the end of the cycle, we may be able to consider some platforms,
> but _only_ if they make use of the consolidated features and therefore
> have _minimal_ additional code.

...this is the negative side of the message - what we're not willing to
accept.  What's the positive side of the message, what can people do to
help?  What is the level of consolidation work that's needed before we
can develop again, and what's needed to make progress there?

For example, with support for new machines are we saying that for
example we're going to refuse to accept anything that isn't device tree
based?  If so then what needs doing?
