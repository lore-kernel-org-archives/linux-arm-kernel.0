From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 22 Apr 2014 21:39:30 +0530
Subject: [PATCH] dmaengine: edma: Add DMA memcpy support
In-Reply-To: <1397875833-31345-1-git-send-email-joelf@ti.com>
References: <1397875833-31345-1-git-send-email-joelf@ti.com>
Message-ID: <20140422160930.GY32284@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 18, 2014 at 09:50:33PM -0500, Joel Fernandes wrote:
> We add DMA memcpy support to EDMA driver. Successful tests performed using
> dmatest kernel module. Copy alignment is set to DMA_SLAVE_BUSWIDTH_4_BYTES and
> users must ensure length is aligned so that copy is performed fully.

Applied, thanks

-- 
~Vinod
