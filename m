From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 25 Nov 2013 15:24:14 +0800
Subject: [PATCH V2 1/6] ahci: imx: Explicitly clear
 IMX6Q_GPR13_SATA_MPLL_CLK_EN
In-Reply-To: <1385118304-27435-1-git-send-email-marex@denx.de>
References: <1385118304-27435-1-git-send-email-marex@denx.de>
Message-ID: <20131125072412.GG11613@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 12:04:59PM +0100, Marek Vasut wrote:
> We must clear this IMX6Q_GPR13_SATA_MPLL_CLK_EN bit on i.MX6Q, otherwise
> Linux will fail to find the attached drive on some boards.
> 
> This entire fix was:
> Reported-by: Eric Nelson <eric.nelson@boundarydevices.com>
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

For patches 1 ~ 3, other than the error that Troy pointed out,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>

> Cc: Richard Zhu <r65037@freescale.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Linux-IDE <linux-ide@vger.kernel.org>
