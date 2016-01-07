From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 7 Jan 2016 11:10:05 +0530
Subject: [PATCH] dmaengine: xgene-dma: Fix double IRQ issue by setting
 IRQ_DISABLE_UNLAZY flag
In-Reply-To: <1450875495-2229-1-git-send-email-rsahu@apm.com>
References: <1450875495-2229-1-git-send-email-rsahu@apm.com>
Message-ID: <20160107054005.GI11778@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 06:28:15PM +0530, Rameshswar Prasad Sahu wrote:
> From: Rameshwar Prasad Sahu <rsahu@apm.com>
> 
> For interrupt controller that doesn't support irq_disable and hardware
> with level interrupt, an extra interrupt can be pending. This patch fixes
> the issue by setting IRQ_DISABLE_UNLAZY flag for the interrupt line.
> 
> Reference: http://git.kernel.org/tip/e9849777d0e27cdd2902805be51da73e7c79578c
> 

Applied now

-- 
~Vinod
