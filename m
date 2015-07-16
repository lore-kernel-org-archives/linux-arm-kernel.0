From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 16 Jul 2015 18:54:11 +0530
Subject: [PATCH] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <1436952778-28000-2-git-send-email-yao.yuan@freescale.com>
References: <1436952778-28000-1-git-send-email-yao.yuan@freescale.com>
 <1436952778-28000-2-git-send-email-yao.yuan@freescale.com>
Message-ID: <20150716132411.GX5086@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 05:32:58PM +0800, Yuan Yao wrote:
> +
> +static const struct dev_pm_ops fsl_edma_pm_ops = {
> +	.suspend_late   = fsl_edma_suspend_late,
> +	.resume_early   = fsl_edma_resume_early,
any reason why you are using early/late handlers?

-- 
~Vinod
