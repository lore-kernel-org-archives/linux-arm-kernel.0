From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 5 Apr 2016 16:44:25 -0700
Subject: [PATCH v2 3/5] dmaengine: qcom: bam_dma: add controlled remotely
 dt property
In-Reply-To: <1459896982-30171-4-git-send-email-stanimir.varbanov@linaro.org>
References: <1459896982-30171-1-git-send-email-stanimir.varbanov@linaro.org>
 <1459896982-30171-4-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <20160405234425.GD11586@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 06, 2016 at 01:56:20AM +0300, Stanimir Varbanov wrote:
>  Documentation/devicetree/bindings/dma/qcom_bam_dma.txt | 2 ++
>  drivers/dma/qcom/bam_dma.c                             | 7 +++++++

The binding should be a separate patch..

>  
> +	bdev->controlled_remotely = of_property_read_bool(pdev->dev.of_node,
> +						"qcom,controlled-remotely");
> +

we need some defaults here, how will this work with boards withe older DT.

-- 
~Vinod
