From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 18 Jun 2012 16:20:58 +0800
Subject: [PATCH 12/16] i2c: imx: remove unneeded mach/irqs.h inclusion
In-Reply-To: <1339653587-4832-13-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-13-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120618082057.GC25447@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:43PM +0800, Shawn Guo wrote:
> Remove unneeded mach/irq.h inclusion from i2c-imx driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-i2c at vger.kernel.org
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/i2c/busses/i2c-imx.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
