From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 12 Oct 2010 00:31:39 +0900
Subject: [PATCH 2/7] perf: New helper function for pmu name
In-Reply-To: <a72a7968f5e3f64a26875457a7451b34f896f5ae.1286584677.git.matt@console-pimps.org>
References: <cover.1286584677.git.matt@console-pimps.org>
	<a72a7968f5e3f64a26875457a7451b34f896f5ae.1286584677.git.matt@console-pimps.org>
Message-ID: <20101011153139.GA12338@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 09, 2010 at 01:46:17AM +0100, Matt Fleming wrote:
> Introduce perf_pmu_name() helper function that returns the name of the
> pmu. This gives us a generic way to get the name of a pmu regardless of
> how an architecture identifies it internally.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
>  arch/sh/kernel/perf_event.c |    9 +++++++++
>  include/linux/perf_event.h  |    1 +
>  kernel/perf_event.c         |    5 +++++
>  3 files changed, 15 insertions(+), 0 deletions(-)
> 
This part is obviously fine with me, too.

Acked-by: Paul Mundt <lethal@linux-sh.org>
