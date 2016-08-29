From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 09:55:34 +0800
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: Use WDOG_B pin reset
In-Reply-To: <1471398402-20559-1-git-send-email-festevam@gmail.com>
References: <1471398402-20559-1-git-send-email-festevam@gmail.com>
Message-ID: <20160829015534.GE30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 10:46:42PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> imx6ul-pico has WDOG1_B pin connected to the PMIC.
> 
> Pass the 'fsl,ext-reset-output' property so that the watchdog
> can trigger a system POR reset via PMIC.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
