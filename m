From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Tue, 14 Feb 2012 16:19:44 +0900
Subject: [PATCHv21 02/16] mm: compaction: introduce
 isolate_migratepages_range()
In-Reply-To: <1328895151-5196-3-git-send-email-m.szyprowski@samsung.com>
References: <1328895151-5196-1-git-send-email-m.szyprowski@samsung.com>
 <1328895151-5196-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120214161944.351244c4.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Feb 2012 18:32:17 +0100
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> From: Michal Nazarewicz <mina86@mina86.com>
> 
> This commit introduces isolate_migratepages_range() function which
> extracts functionality from isolate_migratepages() so that it can be
> used on arbitrary PFN ranges.
> 
> isolate_migratepages() function is implemented as a simple wrapper
> around isolate_migratepages_range().
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Mel Gorman <mel@csn.ul.ie>
> Tested-by: Rob Clark <rob.clark@linaro.org>
> Tested-by: Ohad Ben-Cohen <ohad@wizery.com>
> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
