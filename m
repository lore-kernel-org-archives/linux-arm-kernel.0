From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Dec 2011 16:22:04 +0000
Subject: [PATCH 04/11] mm: compaction: export some of the functions
In-Reply-To: <20111212154015.GI3277@csn.ul.ie>
References: <1321634598-16859-1-git-send-email-m.szyprowski@samsung.com>
 <op.v6dseqji3l0zgt@mpn-glaptop> <20111212154015.GI3277@csn.ul.ie>
Message-ID: <201112121622.04236.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 December 2011, Mel Gorman wrote:
> The bloat exists either way. I don't believe the linker strips it out so
> overall it would make more sense to depend on compaction to keep the
> vmstat counters for debugging reasons if nothing else. It's not
> something I feel very strongly about though.

There were some previous attempts to use -fgc-sections to strip out
unused functions from the kernel, but I think they were never merged
because of regressions.

	Arnd
