From: vkoul@kernel.org (Vinod)
Date: Tue, 2 Oct 2018 20:32:29 +0530
Subject: [PATCH v1 1/1] dmaengine: stm32-dma: check whether length is
 aligned on FIFO threshold
In-Reply-To: <1536651076-17005-1-git-send-email-pierre-yves.mordret@st.com>
References: <1536651076-17005-1-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <20181002150229.GI19792@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-09-18, 09:31, Pierre-Yves MORDRET wrote:
> When a period length is not multiple of FIFO some data may be stuck
> within FIFO.
> 
> Burst/FIFO Threshold/Period or buffer length check has to be hardened
> 
> In any case DMA will grant any request from client but will degraded
> any parameters whether awkward.

Applied, thanks

-- 
~Vinod
