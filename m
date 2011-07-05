From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 5 Jul 2011 13:31:17 +0200
Subject: [PATCH 3/8] mm: alloc_contig_range() added
In-Reply-To: <1309851710-3828-4-git-send-email-m.szyprowski@samsung.com>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<1309851710-3828-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201107051331.17661.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 July 2011, Marek Szyprowski wrote:
> From: Michal Nazarewicz <m.nazarewicz@samsung.com>
> 
> This commit adds the alloc_contig_range() function which tries
> to allecate given range of pages.  It tries to migrate all
> already allocated pages that fall in the range thus freeing them.
> Once all pages in the range are freed they are removed from the
> buddy system thus allocated for the caller to use.
> 
> Signed-off-by: Michal Nazarewicz <m.nazarewicz@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> [m.szyprowski: renamed some variables for easier code reading]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> CC: Michal Nazarewicz <mina86@mina86.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
