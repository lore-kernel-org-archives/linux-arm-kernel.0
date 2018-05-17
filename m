From: vkoul@kernel.org (Vinod)
Date: Thu, 17 May 2018 16:29:49 +0530
Subject: [PATCH] dmaengine: qcom: bam_dma: fix some doc warnings.
In-Reply-To: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
References: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180517105949.GA2932@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-05-18, 10:59, Srinivas Kandagatla wrote:
> Building kernel with W=1 throws up below warnings:
> bam_dma.c:459: warning: Function parameter or member 'dir'
> 	not described in 'bam_chan_init_hw'
> bam_dma.c:697: warning: Function parameter or member 'chan'
> 	not described in 'bam_dma_terminate_all'
> bam_dma.c:697: warning: Excess function parameter 'bchan'
> 	description in 'bam_dma_terminate_all'
> bam_dma.c:964: warning: Function parameter or member 'bchan'
> 	not described in 'bam_start_dma'
> 
> Fix these!.

Applied both, thanks

-- 
~Vinod
