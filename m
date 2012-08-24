From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Aug 2012 14:43:00 +0800
Subject: [PATCH 1/7] mfd: add imx syscon driver based on regmap
In-Reply-To: <1345619928-15446-2-git-send-email-b29396@freescale.com>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-2-git-send-email-b29396@freescale.com>
Message-ID: <20120824064257.GA31998@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 03:18:42PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Add regmap based imx syscon driver.
> This is usually used for access misc bits in registers which does not belong
> to a specific module, for example, IOMUXC GPR and ANATOP.
> With this driver, we provide a standard API for client driver to call to
> access registers which are registered into syscon.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> ---
> Currently it's just simply for IMX, however the driver really is not too
> much imx specific.
> If people want, we probably could extend it to support other platforms too.

Right.  I do not see anything IMX specific there.  We should probably
at least give the driver a generic name from day one.

-- 
Regards,
Shawn
