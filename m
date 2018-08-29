From: vinod.koul@linaro.org (Vinod Koul)
Date: Wed, 29 Aug 2018 21:44:46 +0530
Subject: [PATCH v2 0/9] dmaengine: Use dmaenginem_async_device_register
 to simplify the code
In-Reply-To: <20180806085231.4597-1-sjhuang@iluvatar.ai>
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
Message-ID: <20180829161446.GH2388@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06-08-18, 16:52, Huang Shijie wrote:
> Using the dmaenginem_async_device_register to simplify code for these DMA drivers:
>     1.) dma_async_device_unregister is the last action of drv->remove().
>     2.) the dma driver does not have the ->remove().

Applied, thanks

-- 
~Vinod
