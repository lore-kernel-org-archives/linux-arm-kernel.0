From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 3 Jan 2017 09:27:04 +0530
Subject: [PATCH RESEND] dmaengine: stm32-dma: Rework starting transfer
 management
In-Reply-To: <1483349607-16870-1-git-send-email-cedric.madianga@gmail.com>
References: <1483349607-16870-1-git-send-email-cedric.madianga@gmail.com>
Message-ID: <20170103035703.GE3573@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 10:33:27AM +0100, M'boumba Cedric Madianga wrote:
> This patch reworks the way to manage transfer starting.
> Now, starting DMA is only allowed when the channel is not busy.
> Then, stm32_dma_start_transfer is declared as void.
> At least, after each transfer completion, we start the next transfer if a
> new descriptor as been queued in the issued list during an ongoing
> transfer.

ah sorry, i missed to push topic/stm32-dma. can you rebase onnthis and
resend again. Btw this fails as as well..

-- 
~Vinod
