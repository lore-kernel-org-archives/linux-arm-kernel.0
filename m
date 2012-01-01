From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun,  1 Jan 2012 22:38:10 +0800
Subject: [PATCH v2 0/2] imx-sdma: memory barrier fix 
Message-ID: <1325428692-11473-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v2:
 - add "let sdma_run_channel call sdma_enable_channel"

[PATCH v2 1/2] dma/imx-sdma: let sdma_run_channel call sdma_enable_channel
[PATCH v2 2/2] dma/imx-sdma: add wmb before enable a channel

Thanks
Richard
