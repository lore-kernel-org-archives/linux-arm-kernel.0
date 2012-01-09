From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jan 2012 09:22:32 +0800
Subject: [PATCH v4 2/2] dma/imx-sdma: convert _raw_readl/_raw_writel to
 readl/writel
In-Reply-To: <1326033862-25351-3-git-send-email-richard.zhao@linaro.org>
References: <1326033862-25351-1-git-send-email-richard.zhao@linaro.org>
 <1326033862-25351-3-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120109012230.GC1835@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 08, 2012 at 10:44:22PM +0800, Richard Zhao wrote:
> readl/writel is more genric. And if CONFIG_ARM_DMA_MEM_BUFFERABLE,
> they includes necessary memory barriers.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn
