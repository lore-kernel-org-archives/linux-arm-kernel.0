From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 15 Jun 2012 20:20:59 +0800
Subject: [PATCH 08/16] ARM: imx: leave irq_base of wm8350_platform_data
 uninitialized
In-Reply-To: <1339653587-4832-9-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-9-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120615122058.GF8383@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 01:59:39PM +0800, Shawn Guo wrote:
> With commit d1738ae (mfd: Allocate wm835x irq descs dynamically) being
> in the tree, there is no need to initialize irq_base field of struct
> wm8350_platform_data.  Remove it to save one reference to macro
> MXC_BOARD_IRQ_START.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
