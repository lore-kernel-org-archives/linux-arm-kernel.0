From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Nov 2017 19:10:49 +0800
Subject: [PATCH 2/6] arm: dts: imx: Add missing #phy-cells to usb-nop-xceiv
In-Reply-To: <20171109222614.5719-2-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
 <20171109222614.5719-2-robh@kernel.org>
Message-ID: <20171116110729.GN25384@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 04:26:10PM -0600, Rob Herring wrote:
> "usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
> property. This is probably because the binding was the precursor to the phy
> binding.
> 
> Fixes the following warning in i.MX dts files:
> 
> Warning (phys_property): Missing property '#phy-cells' in node ...
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
