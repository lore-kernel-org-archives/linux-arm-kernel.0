From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun, 8 Jan 2012 22:44:20 +0800
Subject: [PATCH v4 0/2] mx-sdma: memory barrier fix
Message-ID: <1326033862-25351-1-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v4:
 - convert all _raw_readl/_raw_writel to readl/writel.

Changes in v3:
 - use writel instead of explicitly call wmb.

Changes in v2:
 - add "let sdma_run_channel call sdma_enable_channel"




Thanks
Richard
