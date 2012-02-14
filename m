From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Tue, 14 Feb 2012 16:56:16 +0900
Subject: [PATCHv21 07/16] mm: page_alloc: change fallbacks array handling
In-Reply-To: <1328895151-5196-8-git-send-email-m.szyprowski@samsung.com>
References: <1328895151-5196-1-git-send-email-m.szyprowski@samsung.com>
 <1328895151-5196-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120214165616.8b8e36f8.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Feb 2012 18:32:22 +0100
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> From: Michal Nazarewicz <mina86@mina86.com>
> 
> This commit adds a row for MIGRATE_ISOLATE type to the fallbacks array
> which was missing from it.  It also, changes the array traversal logic
> a little making MIGRATE_RESERVE an end marker.  The letter change,
> removes the implicit MIGRATE_UNMOVABLE from the end of each row which
> was read by __rmqueue_fallback() function.
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Mel Gorman <mel@csn.ul.ie>
> Tested-by: Rob Clark <rob.clark@linaro.org>
> Tested-by: Ohad Ben-Cohen <ohad@wizery.com>
> Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
