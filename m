From: mingo@kernel.org (Ingo Molnar)
Date: Sat, 14 Jul 2018 15:01:30 +0200
Subject: [PATCHv3 00/12] atomics: generate atomic headers / instrument
 arm64
In-Reply-To: <20180713150607.rf6hkwsxpe4gsxqt@lakrids.cambridge.arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
 <20180706131603.GA11172@arm.com>
 <20180706132124.GN2494@hirez.programming.kicks-ass.net>
 <20180713150607.rf6hkwsxpe4gsxqt@lakrids.cambridge.arm.com>
Message-ID: <20180714130130.GA23906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> On Fri, Jul 06, 2018 at 03:21:24PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 06, 2018 at 02:16:04PM +0100, Will Deacon wrote:
> > > On Thu, Jul 05, 2018 at 05:40:41PM +0100, Mark Rutland wrote:
> > > > This series scripts the generation of the various atomic headers, to ensure
> > > > that the various atomic APIs remain consistent, reducing the risk of human
> > > > error, and simplifying future rework. This fleshes out the instrumented atomics
> > > > such that arm64 can be migrated over to them.
> > > 
> > > Thanks! For the series apart from the shell scripts:
> > > 
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > Awesome, Ingo can you stuff these here patches into locking/core
> > someplace?
> 
> Looks like Ingo was only Cc'd for the above.
> 
> Ingo, are you happy to pick these up?
> 
> I've pushed out a branch [1] with Will's acks and a trivial commit
> message change for patches 8-10 which I don't think is too important. I
> can post that as v4 if you'd prefer to pick that.

Yeah, please post the very latest to the mailing list.

Thanks!

	Ingo
