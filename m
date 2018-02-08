From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Feb 2018 15:20:30 +0800
Subject: [PATCH 1/7] arm64: dts: ls1012a: Move cpu_thermal out of bus node
In-Reply-To: <1517856338-28289-1-git-send-email-festevam@gmail.com>
References: <1517856338-28289-1-git-send-email-festevam@gmail.com>
Message-ID: <20180208072029.GD31910@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 04:45:32PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Move cpu_thermal node from soc node to root node.
> 
> cpu_thermal node does not have any register properties and thus
> shouldn't be placed on the bus.
> 
> This fixes the following build warnings with W=1:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb: Warning (simple_bus_reg): Node /soc/thermal-zones missing or empty reg/ranges property
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
