From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 13 Jan 2016 18:02:38 +0530
Subject: [PATCH V2 4/8] dmaengine: bcm2835: add additional defines for
 DMA-registers
In-Reply-To: <1452187987-2605-5-git-send-email-kernel@martin.sperl.org>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-5-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160113123238.GB11130@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 05:33:02PM +0000, kernel at martin.sperl.org wrote:
> +#define BCM2835_DMA_PRIORITY(x) ((x & 15) << 16) /* AXI priority */
> +#define BCM2835_DMA_PANIC_PRIORITY(x) ((x & 15) << 20) /* panic priority */
> +#define BCM2835_DMA_WAIT_FOR_WRITES BIT(28) /* current value of
> +					     * TI.BCM2835_DMA_WAIT_RESP
> +					     */

I would put the comment before this, yes is not consistent but is more
readable..


-- 
~Vinod
