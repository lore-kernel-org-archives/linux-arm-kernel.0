From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 Jun 2018 14:43:34 +0800
Subject: [PATCH v2] ARM: dts: imx6sx: fix irq for pcie bridge
In-Reply-To: <20180615074129.16931-1-o.rempel@pengutronix.de>
References: <20180615074129.16931-1-o.rempel@pengutronix.de>
Message-ID: <20180619064333.GE16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2018 at 09:41:29AM +0200, Oleksij Rempel wrote:
> Use the correct IRQ line for the MSI controller in the PCIe host
> controller. Apparently a different IRQ line is used compared to other
> i.MX6 variants. Without this change MSI IRQs aren't properly propagated
> to the upstream interrupt controller.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Added the following Fixes tag and applied as a fix.

 Fixes: b1d17f68e5c5 ("ARM: dts: imx: add initial imx6sx device tree source")

Shawn
