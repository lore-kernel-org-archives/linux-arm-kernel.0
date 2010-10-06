From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 06 Oct 2010 15:41:32 +0200
Subject: [PATCH 1/7] perf: Add helper function to return number of counters
In-Reply-To: <20101006121410.GK13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
	<c4eb88b09da564fe093cc6571ed747971425e69a.1286222593.git.matt@console-pimps.org>
	<20101006121410.GK13563@erda.amd.com>
Message-ID: <1286372492.2144.181.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-06 at 14:14 +0200, Robert Richter wrote:
> > +int perf_num_counters(void)
> > +{
> > +     return armpmu_get_max_events();
> > +}
> > +EXPORT_SYMBOL_GPL(perf_num_counters);
> 
> Peter,
> 
> can you please ack this interface? 

It does seem like the best way forward for this, so

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
