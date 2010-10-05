From: lethal@linux-sh.org (Paul Mundt)
Date: Tue, 5 Oct 2010 17:15:35 +0900
Subject: [PATCH 1/7] perf: Add helper function to return number of counters
In-Reply-To: <c4eb88b09da564fe093cc6571ed747971425e69a.1286222593.git.matt@console-pimps.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	<c4eb88b09da564fe093cc6571ed747971425e69a.1286222593.git.matt@console-pimps.org>
Message-ID: <20101005081535.GC7984@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 04, 2010 at 09:44:19PM +0100, Matt Fleming wrote:
> The number of counters for the registered pmu is needed in a few places
> so provide a helper function that returns this number.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> Tested-by: Will Deacon <will.deacon@arm.com>

Acked-by: Paul Mundt <lethal@linux-sh.org>
