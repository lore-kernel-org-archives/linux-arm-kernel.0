From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Nov 2017 08:25:42 -0800
Subject: [PATCH 5/6] arm: dts: omap: Add missing #phy-cells to
 usb-nop-xceiv
In-Reply-To: <20171109222614.5719-5-robh@kernel.org>
References: <20171109222614.5719-1-robh@kernel.org>
 <20171109222614.5719-5-robh@kernel.org>
Message-ID: <20171110162542.GQ28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [171109 14:28]:
> "usb-nop-xceiv" is using the phy binding, but is missing #phy-cells
> property. This is probably because the binding was the precursor to the phy
> binding.
> 
> Fixes the following warning in OMAP dts files:
> 
> Warning (phys_property): Missing property '#phy-cells' in node ...
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: "Beno?t Cousson" <bcousson@baylibre.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: linux-omap at vger.kernel.org
> ---
> Please apply to TI tree.

Thanks applying into omap-for-v4.15/fixes-dt.

Regards,

Tony
