From: vinod.koul@intel.com (Vinod Koul)
Date: Sat, 5 Dec 2015 15:52:37 +0530
Subject: [PATCH v4] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <1446203038-5323-1-git-send-email-yao.yuan@freescale.com>
References: <1446203038-5323-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <20151205102237.GZ1854@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 07:03:58PM +0800, Yuan Yao wrote:
> This add power management suspend/resume support for the fsl-edma
> driver.
> 
> eDMA acted as a basic function used by others. What it needs to do
> is the two steps below to support power management.
> 
> In fsl_edma_suspend_late:
> Check whether the DMA chan is idle, if it is not idle disable DMA
> request.
> 
> In fsl_edma_resume_early:
> Enable the eDMA and wait for being used.
> 
Applied, thanks

-- 
~Vinod
