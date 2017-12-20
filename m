From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 20 Dec 2017 23:13:47 +0800
Subject: [PATCH v2 01/11] ARM: dts: imx53: Move nodes which have no reg
 property out of bus
In-Reply-To: <1511981684-13433-1-git-send-email-festevam@gmail.com>
References: <1511981684-13433-1-git-send-email-festevam@gmail.com>
Message-ID: <20171220151344.GD3766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 04:54:34PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Move pmu, usbphy0 and usbphy1 nodes from soc node to root node.
> 
> The nodes that have been moved do not have any register properties and thus
> shouldn't be placed on the bus.
> 
> This fixes the following build warnings with W=1:
> 
> arch/arm/boot/dts/imx53-ard.dtb: Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> arch/arm/boot/dts/imx53-ard.dtb: Warning (simple_bus_reg): Node /soc/aips at 50000000/usbphy-0 missing or empty reg/ranges property
> arch/arm/boot/dts/imx53-ard.dtb: Warning (simple_bus_reg): Node /soc/aips at 50000000/usbphy-1 missing or empty reg/ranges property
> arch/arm/boot/dts/imx53-ard.dtb: Warning (simple_bus_reg): Node /soc/pmu missing or empty reg/ranges property
> 
> Based on a patch from Simon Horman for r8a7795.dtsi.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
