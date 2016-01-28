From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jan 2016 16:34:08 +0800
Subject: [PATCH v2 1/4] ARM: dts: imx7d: add arch timer
In-Reply-To: <1452014237-12848-1-git-send-email-Frank.Li@nxp.com>
References: <1452014237-12848-1-git-send-email-Frank.Li@nxp.com>
Message-ID: <20160128083408.GP9070@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 11:17:14AM -0600, Frank Li wrote:
> From: Frank Li <Frank.Li@freescale.com>
> 
> Since uboot v2016.01-rc2, which supported basic psci for i.mx7d.
> So imx7d's second core can be enabled by psci.
> 
> Without arch timer, every timer event will be boardcasted to each core.
> arch timer has local timer irq for each core.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Applied all, thanks.
