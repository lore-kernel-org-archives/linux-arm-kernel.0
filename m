From: mel@csn.ul.ie (Mel Gorman)
Date: Fri, 3 Feb 2012 13:30:50 +0000
Subject: [PATCH 03/15] mm: compaction: introduce map_pages()
In-Reply-To: <1328271538-14502-4-git-send-email-m.szyprowski@samsung.com>
References: <1328271538-14502-1-git-send-email-m.szyprowski@samsung.com>
 <1328271538-14502-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120203133050.GE5796@csn.ul.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2012 at 01:18:46PM +0100, Marek Szyprowski wrote:
> From: Michal Nazarewicz <mina86@mina86.com>
> 
> This commit creates a map_pages() function which map pages freed
> using split_free_pages().  This merely moves some code from
> isolate_freepages() so that it can be reused in other places.
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Mel Gorman <mel@csn.ul.ie>

-- 
Mel Gorman
SUSE Labs
