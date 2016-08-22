From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 22 Aug 2016 11:53:19 +0530
Subject: [PATCH -next] dmaengine: at_xdmac: fix to pass correct device
 identity to free_irq()
In-Reply-To: <1470799029-2613-1-git-send-email-weiyj.lk@gmail.com>
References: <1470799029-2613-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160822062318.GL2890@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 03:17:09AM +0000, Wei Yongjun wrote:
> free_irq() expects the same device identity that was passed to
> corresponding request_irq(), otherwise the IRQ is not freed.

Applied, thanks

-- 
~Vinod
