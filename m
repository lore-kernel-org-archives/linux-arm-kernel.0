From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 11 Sep 2014 10:48:26 +0530
Subject: [PATCH 1/2] dma: mmp_tdma: add DMA_PREP_INTERRUPT flag support
In-Reply-To: <1410338449-13961-1-git-send-email-zhouqiao@marvell.com>
References: <1410338449-13961-1-git-send-email-zhouqiao@marvell.com>
Message-ID: <20140911051826.GD3131@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 04:40:48PM +0800, Qiao Zhou wrote:
> add DMA_PREP_INTERRUPT flag to support no_period_wakeup, in which
> user space app doesn't want audio interrupt to wake up audio threads.
> 

Applied now, after fixing subsystem name.

-- 
~Vinod
