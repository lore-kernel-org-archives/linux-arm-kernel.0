From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 19 Aug 2013 14:17:04 +0530
Subject: [PATCH] dma: imx-sdma: remove the unused completion
In-Reply-To: <1373010655-3800-1-git-send-email-b32955@freescale.com>
References: <1373010655-3800-1-git-send-email-b32955@freescale.com>
Message-ID: <20130819084704.GW32147@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 03:50:55PM +0800, Huang Shijie wrote:
> After the patch: "2ccaef0 dma: imx-sdma: make channel0 operations atomic",
> the "done" completion is not used any more.
> 
> Just remove it.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
Applied, thanks

~Vinod
