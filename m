From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 10 Jan 2017 11:06:12 +0800
Subject: [PATCH] ARM: dts: imx53-qsb: Provide the TVE DAC regulators
In-Reply-To: <1483470751-8073-1-git-send-email-festevam@gmail.com>
References: <1483470751-8073-1-git-send-email-festevam@gmail.com>
Message-ID: <20170110030611.GV20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 05:12:31PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> On imx53-qsb the TVE DAC regulator comes from:
> 
> - LDO7 on the board with the Dialog DA9052 PMIC
> - VDAC on the board with the MC34708 PMIC
> 
> Pass them in the 'dac-supply' node.
> 
> While at it, remove the 'regulator-always-on/regulator-boot-on'
> properties as the TVE driver will properly handle it.
> 
> Tested on a imx53-qsb board with a Dialog DA9052 PMIC.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
