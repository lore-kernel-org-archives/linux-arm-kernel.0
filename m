From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Oct 2018 16:58:18 +0100
Subject: [PATCH] Doc: lockdep: add information about performance impact
In-Reply-To: <20181009154359.GB5728@hirez.programming.kicks-ass.net>
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
 <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
 <20181009154359.GB5728@hirez.programming.kicks-ass.net>
Message-ID: <20181009155818.GD9259@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2018 at 05:43:59PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
> > This patch add some warning related to performance drop.
> > It should be mentioned that this is not for free
> > and the platfrom resources (cache, bus interconnect, etc.)
> > will be used more frequently.
> 
> To me this reads a bit like: water is wet.
> 
> Is this really needed?

I don't think so -- this is a debug option under "kernel hacking". Surely
the perf hit comes with the territory.

Will
