From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Dec 2013 15:20:41 +0800
Subject: [PATCH V3 1/3] ahci: imx: Explicitly clear
 IMX6Q_GPR13_SATA_MPLL_CLK_EN
In-Reply-To: <20131129222818.GM21755@mtj.dyndns.org>
References: <1385369222-5288-1-git-send-email-marex@denx.de>
 <20131129222818.GM21755@mtj.dyndns.org>
Message-ID: <20131203072039.GD10840@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 05:28:18PM -0500, Tejun Heo wrote:
> On Mon, Nov 25, 2013 at 09:47:00AM +0100, Marek Vasut wrote:
> > We must clear this IMX6Q_GPR13_SATA_MPLL_CLK_EN bit on i.MX6Q, otherwise
> > Linux will fail to find the attached drive on some boards.
> > 
> > This entire fix was:
> > Reported-by: Eric Nelson <eric.nelson@boundarydevices.com>
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Richard Zhu <r65037@freescale.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Linux-IDE <linux-ide@vger.kernel.org>
> 
> There have been a lot of review activities on this series.  If you
> guys more or less agree now, can you please reply with
> acked/reviewed-by's?

For the series,

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
