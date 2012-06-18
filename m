From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 18 Jun 2012 16:20:27 +0800
Subject: [PATCH 11/16] ARM: imx: add a legacy irqdomain for mx31ads
In-Reply-To: <1339653587-4832-12-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-12-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120618082026.GB25447@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:42PM +0800, Shawn Guo wrote:
> Call irq_alloc_descs to get the irq_base for mx31ads, and add a legacy
> irqdomain using the irq_base, so that the mapping between mx31ads
> hardware irq and Linux irq number can be dynamically handled by
> irqdomain.  As the result, the use of MXC_BOARD_IRQ_START can be
> completely removed from mach-mx31ads.c.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-imx/mach-mx31ads.c |   48 ++++++++++++++++++++++++-------------
>  1 files changed, 31 insertions(+), 17 deletions(-)
> 

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
