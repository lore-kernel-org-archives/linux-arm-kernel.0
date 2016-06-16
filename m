From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Jun 2016 09:55:36 +0800
Subject: [PATCH 1/4] ARM: dts: imx6qdl-sabresd: Use WDOG_B pin reset
In-Reply-To: <1465866479-15953-1-git-send-email-festevam@gmail.com>
References: <1465866479-15953-1-git-send-email-festevam@gmail.com>
Message-ID: <20160616015536.GR20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 10:07:56PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> imx6qdl-sabresd has WDOG2_B pin connected to the PMIC. 
> 
> Pass the 'fsl,ext-reset-output' property so that the watchdog
> can trigger a system POR reset via the PMIC.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
