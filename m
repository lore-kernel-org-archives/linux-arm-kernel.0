From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 31 Jan 2012 09:05:15 +0530
Subject: [PATCH v2 0/6] imx-sdma: patches when I enable imx6q sabrelite
 audio
In-Reply-To: <20120113031349.GH2414@b20223-02.ap.freescale.net>
References: <1326424201-20056-1-git-send-email-richard.zhao@linaro.org>
 <20120113031349.GH2414@b20223-02.ap.freescale.net>
Message-ID: <1327980915.1527.56.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-01-13 at 11:13 +0800, Richard Zhao wrote:
> Changes in v2:
>  - convert to use bit ops
> 
> > [PATCH v2 1/6] dma/imx-sdma: let sdma_run_channel call
> > [PATCH v2 2/6] dma/imx-sdma: use readl_relaxed/writel_relaxed and
> > [PATCH v2 3/6] dma/imx-sdma: call sdma_set_channel_priority after
> > [PATCH v2 4/6] dma/imx-sdma: move clk_enable out of
> > [PATCH v2 5/6] dma/imx-sdma: use num_events to validate event_id0
> > [PATCH v2 6/6] dma/imx-sdma: convernt to use bit ops
> > 
> > Thanks
> > Richard
> > 
Thanks Applied all, with a typo fix in 4 in change log

-- 
~Vinod
