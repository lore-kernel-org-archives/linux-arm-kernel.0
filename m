From: vinod.koul@linaro.org (Vinod Koul)
Date: Thu, 17 May 2018 16:20:49 +0530
Subject: [PATCH] dmaengine: qcom: bam_dma: fix some doc warnings.
In-Reply-To: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
References: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
Message-ID: <20180517105049.GZ13271@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-05-18, 10:59, Srinivas Kandagatla wrote:
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 4a828c18099a..a05fff8a1447 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -451,7 +451,7 @@ static void bam_reset_channel(struct bam_chan *bchan)
>  /**
>   * bam_chan_init_hw - Initialize channel hardware
>   * @bchan: bam channel
> - *
> + * @dir: DMA transfer direction

Do you want to add an empty line here?

>   * This function resets and initializes the BAM channel
-- 
~Vinod
