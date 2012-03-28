From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 28 Mar 2012 13:15:03 +0900
Subject: [PATCHv2 07/14] SH: adapt for dma_map_ops changes
In-Reply-To: <1332855768-32583-8-git-send-email-m.szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-8-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120328041503.GM26543@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 03:42:41PM +0200, Marek Szyprowski wrote:
> From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> 
> Adapt core SH architecture code for dma_map_ops changes: replace
> alloc/free_coherent with generic alloc/free methods.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Paul Mundt <lethal@linux-sh.org>
