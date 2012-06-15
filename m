From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 15 Jun 2012 17:23:08 +0800
Subject: [PATCH 03/16] ARM: imx: eliminate macro IRQ_GPIOx()
In-Reply-To: <1339653587-4832-4-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120615092306.GA8383@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:34PM +0800, Shawn Guo wrote:
> This patch changes all the static gpio irq number assigning with
> IRQ_GPIOA() ... IRQ_GPIOF() to run-time assigning with gpio_to_irq
> call, and in turn eliminates these macros.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
