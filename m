From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Jul 2017 16:44:29 +0800
Subject: [PATCH 1/4] ARM: dts: imx7d-sdb: Put pinctrl_spi4 in the correct
 location
In-Reply-To: <1498855385-9690-1-git-send-email-festevam@gmail.com>
References: <1498855385-9690-1-git-send-email-festevam@gmail.com>
Message-ID: <20170712084428.GL3172@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 05:43:02PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> pinctrl_spi4 pin group is not part of the low power iomux controller,
> so move it under the normal iomuxc node.
> 
> Fixes: 184f39b57cab6 ("ARM: dts: imx7d-sdb: Add GPIO expander node")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
