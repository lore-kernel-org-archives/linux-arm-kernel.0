From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 21 Dec 2017 15:44:23 +0800
Subject: [PATCH] ARM: dts: imx6qdl-zii-rdu2: Remove device_type from PCI
 subnode
In-Reply-To: <1512234488-8760-1-git-send-email-festevam@gmail.com>
References: <1512234488-8760-1-git-send-email-festevam@gmail.com>
Message-ID: <20171221074422.GE23230@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 02, 2017 at 03:08:08PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> device_type = "pci" should be used for the SoC level PCI controller and
> it is already present at imx6qdl.dtsi.
> 
> Remove it from the subnode in order to fix the following build
> warnings with W=1:
> 
> arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (pci_bridge): Node /soc/pcie at 1ffc000/pci at 0 missing ranges for PCI bridge (or not a bridge)
> arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (pci_bridge): Node /soc/pcie at 1ffc000/pci at 0 missing bus-range for PCI bridge
> arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (unit_address_format): Failed prerequisite 'pci_bridge'
> arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (pci_device_reg): Failed prerequisite 'pci_bridge'
> arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (pci_device_bus_num): Failed prerequisite 'pci_bridge'
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
