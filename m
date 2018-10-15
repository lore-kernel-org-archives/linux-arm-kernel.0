From: vkoul@kernel.org (Vinod)
Date: Mon, 15 Oct 2018 22:37:11 +0530
Subject: [PATCH 1/7] dmaengine: fsldma: Replace DMA_IN/OUT by
 FSL_DMA_IN/OUT
In-Reply-To: <20181011094655.45707-1-peng.ma@nxp.com>
References: <20181011094655.45707-1-peng.ma@nxp.com>
Message-ID: <20181015170711.GK2400@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-10-18, 17:46, Peng Ma wrote:
> From: Wen He <wen.he_1@nxp.com>
> 
> This patch implement a standard macro call functions is
> used to NXP dma drivers.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>

Please read Documentation/process/submitting-patches.rst, we expect each
patch you send to have your signed off and signed off from orignal
authors

Also as Rob pointed out this patch series should be v8 or so as this is
following the previous work submitted to the list

Please also indicated changes from last rev which help in the review.


-- 
~Vinod
