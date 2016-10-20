From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Oct 2016 12:01:09 +0100
Subject: [PATCH v3 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <20161020105501.GU3102@twins.programming.kicks-ass.net>
References: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
 <20161020103707.GB3175@twins.programming.kicks-ass.net>
 <20161020104417.GD10234@leverpostej>
 <20161020105501.GU3102@twins.programming.kicks-ass.net>
Message-ID: <20161020110109.GE10234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 12:55:01PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 20, 2016 at 11:44:18AM +0100, Mark Rutland wrote:
> > I think there's general confusion over the use of invalid context.
> > Perhaps we could clear that up with:
> > 
> > #define perf_uncore_context	perf_invalid_context
> > 
> > and
> > 
> > s/perf_hw_context/perf_cpu_hw_context/
> 
> What might be missing is the fact that these are _TASK_ contexts.

Yes, that too.

> New names might clarify things a little though.

I'll add that to the list of cleanup/rework I've been meaning to look
at.

Thanks,
Mark.
