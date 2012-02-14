From: kamezawa.hiroyu@jp.fujitsu.com (KAMEZAWA Hiroyuki)
Date: Tue, 14 Feb 2012 16:25:58 +0900
Subject: [PATCHv21 03/16] mm: compaction: introduce map_pages()
In-Reply-To: <1328895151-5196-4-git-send-email-m.szyprowski@samsung.com>
References: <1328895151-5196-1-git-send-email-m.szyprowski@samsung.com>
 <1328895151-5196-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120214162558.13e9ff24.kamezawa.hiroyu@jp.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Feb 2012 18:32:18 +0100
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> From: Michal Nazarewicz <mina86@mina86.com>
> 
> This commit creates a map_pages() function which map pages freed
> using split_free_pages().  This merely moves some code from
> isolate_freepages() so that it can be reused in other places.
> 
> Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Mel Gorman <mel@csn.ul.ie>

Reviewed-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
