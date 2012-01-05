From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 5 Jan 2012 15:59:20 +0800
Subject: [PATCH v3 0/2] imx-sdma: memory barrier fix
Message-ID: <1325750362-22598-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v3:
 - use writel instead of explicitly call wmb.

Changes in v2:
 - add "let sdma_run_channel call sdma_enable_channel"

[PATCH v3 1/2] dma/imx-sdma: let sdma_run_channel call
[PATCH v3 2/2] dma/imx-sdma: use writel to write register when

Thanks
Richard
