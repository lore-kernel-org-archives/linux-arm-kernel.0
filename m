From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 6 Jul 2013 13:13:45 +0800
Subject: [PATCH] dma: imx-sdma: remove the unused completion
In-Reply-To: <1373010655-3800-1-git-send-email-b32955@freescale.com>
References: <1373010655-3800-1-git-send-email-b32955@freescale.com>
Message-ID: <20130706051343.GD30164@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 03:50:55PM +0800, Huang Shijie wrote:
> After the patch: "2ccaef0 dma: imx-sdma: make channel0 operations atomic",
> the "done" completion is not used any more.
> 
> Just remove it.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
