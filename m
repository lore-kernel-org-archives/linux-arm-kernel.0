From: vbabka@suse.cz (Vlastimil Babka)
Date: Fri, 20 Jan 2017 14:35:26 +0100
Subject: [PATCH 3/3] mm: wire up GFP flag passing in
 dma_alloc_from_contiguous
In-Reply-To: <20170119170707.31741-3-l.stach@pengutronix.de>
References: <20170119170707.31741-1-l.stach@pengutronix.de>
 <20170119170707.31741-3-l.stach@pengutronix.de>
Message-ID: <139e94c3-4d03-de35-0c91-217c73c0f5f2@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/19/2017 06:07 PM, Lucas Stach wrote:
> The callers of the DMA alloc functions already provide the proper
> context GFP flags. Make sure to pass them through to the CMA
> allocator, to make the CMA compaction context aware.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
