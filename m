From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 16 Apr 2018 16:44:59 +0800
Subject: [PATCH] ARM: dts: imx7: Move tempmon node out of bus
In-Reply-To: <1521136930-14660-1-git-send-email-festevam@gmail.com>
References: <1521136930-14660-1-git-send-email-festevam@gmail.com>
Message-ID: <20180416084458.GH25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2018 at 03:02:10PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Move tempmon node from soc node to root node.
>     
> tempmon node does not have any register properties and thus
> shouldn't be placed on the bus.
>     
> This fixes the following build warning with W=1:
> 
> arch/arm/boot/dts/imx7d-cl-som-imx7.dtb: Warning (simple_bus_reg): Node /soc/aips-bus at 30000000/tempmon missing or empty reg/ranges property
> 
> Fixes: de25b9bb4a40 ("ARM: dts: imx7s: add temperature monitor support")
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
