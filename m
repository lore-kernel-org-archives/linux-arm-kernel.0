From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 15 Jun 2012 20:21:25 +0800
Subject: [PATCH 09/16] ARM: imx: pass gpio than irq number into
 mxc_expio_init
In-Reply-To: <1339653587-4832-10-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-10-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120615122124.GG8383@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:40PM +0800, Shawn Guo wrote:
> Change mxc_expio_init interface a little bit to have gpio than irq
> number passed in.  With the change, gpio_to_irq can be called inside
> mxc_expio_init to get irq number, so that MXC_IRQ_TO_GPIO can be
> removed.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
