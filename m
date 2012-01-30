From: mel@csn.ul.ie (Mel Gorman)
Date: Mon, 30 Jan 2012 12:12:50 +0000
Subject: [PATCH 07/15] mm: page_alloc: change fallbacks array handling
In-Reply-To: <1327568457-27734-8-git-send-email-m.szyprowski@samsung.com>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120130121250.GK25268@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 10:00:49AM +0100, Marek Szyprowski wrote:
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

Acked-by: Mel Gorman <mel@csn.ul.ie>

-- 
Mel Gorman
SUSE Labs
