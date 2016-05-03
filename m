From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 3 May 2016 12:25:34 +0530
Subject: [PATCH 0/5] Use dma_pool_zalloc
In-Reply-To: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <20160503065533.GO2274@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2016 at 10:09:07PM +0200, Julia Lawall wrote:
> Dma_pool_zalloc combines dma_pool_alloc and memset 0.  The semantic patch
> that makes this transformation is as follows: (http://coccinelle.lip6.fr/)

Applied all dmaengine patches

-- 
~Vinod
