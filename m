From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 16 Jul 2015 18:32:37 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix the resource map to handle
 overlapping
In-Reply-To: <1436263465-7677-1-git-send-email-rsahu@apm.com>
References: <1436263465-7677-1-git-send-email-rsahu@apm.com>
Message-ID: <20150716130237.GR5086@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 07, 2015 at 03:34:25PM +0530, Rameshwar Prasad Sahu wrote:
> There is an overlap in dma ring cmd csr region due to sharing of ethernet
> ring cmd csr region. This patch fix the resource overlapping by mapping
> the entire dma ring cmd csr region.

Applied thanks

-- 
~Vinod
