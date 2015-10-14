From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 14 Oct 2015 20:21:00 +0530
Subject: [PATCH] dmaengine: xgene-dma: Remove memcpy offload support due
 to performance drop
In-Reply-To: <1444830907-8035-1-git-send-email-rsahu@apm.com>
References: <1444830907-8035-1-git-send-email-rsahu@apm.com>
Message-ID: <20151014145100.GX27370@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 07:25:07PM +0530, Rameshwar Prasad Sahu wrote:
> The DMA engine supports memory copy, RAID5 XOR, RAID6 PQ, and other
> computations. But the bandwidth of the entire DMA engine is shared
> among all channels. This patch re-configures operations availability
> such that one can achieve maximum performance for XOR and PQ
> computation by removing the memory offload operations.

Applied, thanks

-- 
~Vinod
