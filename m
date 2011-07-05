From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Jul 2011 13:30:07 +0200
Subject: [PATCH 2/8] mm: alloc_contig_freed_pages() added
In-Reply-To: <1309851710-3828-3-git-send-email-m.szyprowski@samsung.com>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<1309851710-3828-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201107051330.07443.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Marek Szyprowski wrote:
> From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> 
> This commit introduces alloc_contig_freed_pages() function
> which allocates (ie. removes from buddy system) free pages
> in range.  Caller has to guarantee that all pages in range
> are in buddy system.
> 
> Along with this function, a free_contig_pages() function is
> provided which frees all (or a subset of) pages allocated
> with alloc_contig_free_pages().
> 
> Michal Nazarewicz has modified the function to make it easier
> to allocate not MAX_ORDER_NR_PAGES aligned pages by making it
> return pfn of one-past-the-last allocated page.
> 
> Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
> Signed-off-by: Michal Nazarewicz <m.nazarewicz@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Michal Nazarewicz <mina86@mina86.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
