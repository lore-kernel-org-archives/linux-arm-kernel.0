From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 14 Jun 2012 15:59:15 +0800
Subject: [PATCH 02/16] ARM: imx: eliminate macro IOMUX_TO_IRQ()
In-Reply-To: <1339653587-4832-3-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120614075914.GC2086@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:33PM +0800, Shawn Guo wrote:
> This patch changes all the static gpio irq number assigning with
> IOMUX_TO_IRQ()
Hmm, we have too many ways to get gpio irq number before...

> to run-time assigning with gpio_to_irq call, and
> in turn eliminates the macro IOMUX_TO_IRQ().
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
