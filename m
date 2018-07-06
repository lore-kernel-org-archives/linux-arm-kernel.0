From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 6 Jul 2018 15:21:24 +0200
Subject: [PATCHv3 00/12] atomics: generate atomic headers / instrument
 arm64
In-Reply-To: <20180706131603.GA11172@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
 <20180706131603.GA11172@arm.com>
Message-ID: <20180706132124.GN2494@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2018 at 02:16:04PM +0100, Will Deacon wrote:
> Hi Mark,
> 
> On Thu, Jul 05, 2018 at 05:40:41PM +0100, Mark Rutland wrote:
> > This series scripts the generation of the various atomic headers, to ensure
> > that the various atomic APIs remain consistent, reducing the risk of human
> > error, and simplifying future rework. This fleshes out the instrumented atomics
> > such that arm64 can be migrated over to them.
> 
> Thanks! For the series apart from the shell scripts:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Awesome, Ingo can you stuff these here patches into locking/core
someplace?
