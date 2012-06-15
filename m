From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 15 Jun 2012 20:22:08 +0800
Subject: [PATCH 10/16] ARM: imx: add a legacy irqdomain for 3ds_debugboard
In-Reply-To: <1339653587-4832-11-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-11-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120615122207.GH8383@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:41PM +0800, Shawn Guo wrote:
> Call irq_alloc_descs to get the irq_base for 3ds_debugboard, and add
> a legacy irqdomain using the irq_base, so that the mapping between
> 3ds_debugboard hardware irq and Linux irq number can be dynamically
> handled by irqdomain.  As the result, the use of MXC_BOARD_IRQ_START
> can be completely removed from 3ds_debugboard.c.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/plat-mxc/3ds_debugboard.c |   42 +++++++++++++++++++++--------------
>  1 files changed, 25 insertions(+), 17 deletions(-)
> 
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
