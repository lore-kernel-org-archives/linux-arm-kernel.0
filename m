From: peterz@infradead.org (Peter Zijlstra)
Date: Mon, 11 Oct 2010 11:31:39 +0200
Subject: [PATCH 2/7] perf: New helper function for pmu name
In-Reply-To: <20101011091809.GQ13563@erda.amd.com>
References: <cover.1286584677.git.matt@console-pimps.org>
	<a72a7968f5e3f64a26875457a7451b34f896f5ae.1286584677.git.matt@console-pimps.org>
	<20101011091809.GQ13563@erda.amd.com>
Message-ID: <1286789499.2336.206.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-11 at 11:18 +0200, Robert Richter wrote:
> On 08.10.10 20:46:17, Matt Fleming wrote:
> > Introduce perf_pmu_name() helper function that returns the name of the
> > pmu. This gives us a generic way to get the name of a pmu regardless of
> > how an architecture identifies it internally.
> > 
> > Signed-off-by: Matt Fleming <matt@console-pimps.org>
> 
> Peter, I need your ack here.

Sure,

Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
