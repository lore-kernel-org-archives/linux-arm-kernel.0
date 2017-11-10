From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Nov 2017 08:26:01 -0800
Subject: [PATCH 6/6] arm: dts: am33xx: Add missing #phy-cells to
 ti,am335x-usb-phy
In-Reply-To: <20171109222614.5719-6-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
 <20171109222614.5719-6-robh@kernel.org>
Message-ID: <20171110162601.GR28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [171109 14:28]:
> "ti,am335x-usb-phy" is using the phy binding, but is missing #phy-cells
> property. Fixes the following warning in TI dts files:
> 
> Warning (phys_property): Missing property '#phy-cells' in node ...
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap at vger.kernel.org
> ---
> Please apply to TI tree.

Applying this too into omap-for-v4.15/fixes-dt thanks.

Tony
