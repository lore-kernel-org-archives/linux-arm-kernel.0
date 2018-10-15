From: vkoul@kernel.org (Vinod)
Date: Mon, 15 Oct 2018 22:40:10 +0530
Subject: [PATCH] dmaengine: owl: Fix warnings generated during build
In-Reply-To: <20181008171631.5603-1-manivannan.sadhasivam@linaro.org>
References: <20181008171631.5603-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20181015171010.GL2400@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-10-18, 22:46, Manivannan Sadhasivam wrote:
> Following warnings are generated when compiled with W=1,
> 
> drivers/dma/owl-dma.c:170: warning: Function parameter or member 'cyclic'
> not described in 'owl_dma_txd'
> drivers/dma/owl-dma.c:198: warning: Function parameter or member 'cfg' not
> described in 'owl_dma_vchan'
> drivers/dma/owl-dma.c:198: warning: Function parameter or member 'drq' not
> described in 'owl_dma_vchan'
> drivers/dma/owl-dma.c:225: warning: Function parameter or member 'irq' not
> described in 'owl_dma'
> 
> Fix this by adding comments for relevant struct members to appear in
> kernel-doc.
> 
> Fixes: d64e1b3f5cce ("dmaengine: owl: Add Slave and Cyclic mode support for
> Actions Semi Owl S900 SoC")
> 

This empty line is not required

> Reported-by: Vinod Koul <vinod.koul@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


Applied after removing the bogus empty line, thanks
-- 
~Vinod
