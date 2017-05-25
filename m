From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 25 May 2017 15:51:04 +0800
Subject: [PATCH 1/2] ARM: dts: imx7d-pico: Add watchdog support
In-Reply-To: <1495552569-18567-1-git-send-email-fabio.estevam@nxp.com>
References: <1495552569-18567-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20170525075102.GZ26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 12:16:08PM -0300, Fabio Estevam wrote:
> imx7d-pico has the WDOG1_B pin connected to the PMIC, so add the
> wdog1 node and use the 'fsl,ext-reset-output' property to
> properly describe it.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied both, thanks.
