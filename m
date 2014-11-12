From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 12 Nov 2014 15:01:58 +0530
Subject: [PATCH 0/2] dma: pl330: Fixes for DMA memcpy
In-Reply-To: <1415383518-29327-1-git-send-email-tixy@linaro.org>
References: <1415383518-29327-1-git-send-email-tixy@linaro.org>
Message-ID: <20141112093158.GB24582@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 06:05:16PM +0000, Jon Medhurst wrote:
> This is a couple of patches I produced when trying to get dmatest to run
> with the pl330 driver. The second one is actually a theoretical fix
> because the FIFO on the platform I was using is too large for the tests
> to hit the limit, but the datasheet says the device can lockup if all
> the FIFO entries are exhausted, so it seems like a sensible precaution.
>
Applied, thanks

Please ensure you use the right subsystem name for the patch header

-- 
~Vinod
