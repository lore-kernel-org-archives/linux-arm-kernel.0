From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 5 Oct 2010 17:10:57 +0900
Subject: [PATCH 2/7] perf: New helper function for pmu name
In-Reply-To: <59a8e68894a2e755232189abbe9b1a3b892e309c.1286222593.git.matt@console-pimps.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	<59a8e68894a2e755232189abbe9b1a3b892e309c.1286222593.git.matt@console-pimps.org>
Message-ID: <20101005081057.GB7984@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 09:44:20PM +0100, Matt Fleming wrote:
> Introduce perf_pmu_name() helper function that returns the name of the
> pmu. This gives us a generic way to get the name of a pmu regardless of
> how an architecture identifies it internally, e.g. ARM uses an id
> whereas SH currently uses a string.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

This looks fine too. Later we can see about switching the SH case over to
CPU subtype IDs, but it doesn't matter for now.

Acked-by: Paul Mundt <lethal@linux-sh.org>
