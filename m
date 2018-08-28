From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 28 Aug 2018 01:57:46 +0000
Subject: [PATCH] pinctrl: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-40-robh@kernel.org>
Message-ID: <AM0PR04MB4211652B5C4C4CD91EA17297800A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Tuesday, August 28, 2018 9:53 AM
> To: linux-kernel at vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>; A.s. Dong
> <aisheng.dong@nxp.com>; Fabio Estevam <festevam@gmail.com>; Shawn
> Guo <shawnguo@kernel.org>; Stefan Agner <stefan@agner.ch>; Pengutronix
> Kernel Team <kernel@pengutronix.de>; Sean Wang
> <sean.wang@mediatek.com>; Matthias Brugger <matthias.bgg@gmail.com>;
> Carlo Caione <carlo@caione.org>; Kevin Hilman <khilman@baylibre.com>;
> Jason Cooper <jason@lakedaemon.net>; Andrew Lunn <andrew@lunn.ch>;
> Gregory Clement <gregory.clement@bootlin.com>; Sebastian Hesselbarth
> <sebastian.hesselbarth@gmail.com>; Jean-Christophe Plagniol-Villard
> <plagnioj@jcrosoft.com>; Nicolas Ferre <nicolas.ferre@microchip.com>;
> Alexandre Belloni <alexandre.belloni@bootlin.com>; Heiko Stuebner
> <heiko@sntech.de>; Tony Lindgren <tony@atomide.com>; Haojian Zhuang
> <haojian.zhuang@linaro.org>; Patrice Chotard <patrice.chotard@st.com>;
> Barry Song <baohua@kernel.org>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@st.com>; Maxime Ripard <maxime.ripard@bootlin.com>;
> Chen-Yu Tsai <wens@csie.org>; linux-gpio at vger.kernel.org;
> linux-mediatek at lists.infradead.org; linux-arm-kernel at lists.infradead.org;
> linux-amlogic at lists.infradead.org; linux-rockchip at lists.infradead.org;
> linux-omap at vger.kernel.org
> Subject: [PATCH] pinctrl: Convert to using %pOFn instead of device_node.name
> 
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-mediatek at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-amlogic at lists.infradead.org
> Cc: linux-rockchip at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pinctrl/berlin/berlin.c               |  6 ++--
>  drivers/pinctrl/freescale/pinctrl-imx.c       |  7 ++--
>  drivers/pinctrl/freescale/pinctrl-imx1-core.c | 12 +++----

For i.MX,
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
