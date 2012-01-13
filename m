From: richard.zhao@linaro.org (Richard Zhao)
Date: Fri, 13 Jan 2012 11:09:55 +0800
Subject: [PATCH v2 0/6] imx-sdma: patches when I enable imx6q sabrelite audio
Message-ID: <1326424201-20056-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[PATCH v2 1/6] dma/imx-sdma: let sdma_run_channel call
[PATCH v2 2/6] dma/imx-sdma: use readl_relaxed/writel_relaxed and
[PATCH v2 3/6] dma/imx-sdma: call sdma_set_channel_priority after
[PATCH v2 4/6] dma/imx-sdma: move clk_enable out of
[PATCH v2 5/6] dma/imx-sdma: use num_events to validate event_id0
[PATCH v2 6/6] dma/imx-sdma: convernt to use bit ops

Thanks
Richard
