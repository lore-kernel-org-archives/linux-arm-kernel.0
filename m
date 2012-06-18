From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 18 Jun 2012 16:22:08 +0800
Subject: [PATCH 14/16] tty: serial: imx: remove the use of
 MXC_INTERNAL_IRQS
In-Reply-To: <1339653587-4832-15-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-15-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120618082207.GE25447@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:45PM +0800, Shawn Guo wrote:
> As the part of the effort to enable SPARE_IRQ for imx platform,
> the macro MXC_INTERNAL_IRQS will be removed.  The imx serial driver
> has a references to it for a decision on flags of request_irq call
> based on rtsirq is beyond MXC_INTERNAL_IRQS.  However the searching
> on imx platform code tells that rtsirq will never be beyond
> MXC_INTERNAL_IRQS.  That said, the check, consequently the reference
> to MXC_INTERNAL_IRQS are not needed, so remove them.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: linux-serial at vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
