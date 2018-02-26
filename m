From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 26 Feb 2018 11:17:01 +0800
Subject: [PATCH v2 2/4] arm64: add basic DTS for i.MX8MQ
In-Reply-To: <AM3PR04MB306E1344C6242887F4797AC80C20@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <20180201183126.32384-1-l.stach@pengutronix.de>
 <20180201183126.32384-2-l.stach@pengutronix.de>
 <AM3PR04MB306E1344C6242887F4797AC80C20@AM3PR04MB306.eurprd04.prod.outlook.com>
Message-ID: <20180226031700.GS3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 25, 2018 at 10:47:11AM +0000, A.s. Dong wrote:
> >  Documentation/devicetree/bindings/arm/fsl.txt  |   4 +
> >  arch/arm64/boot/dts/freescale/imx8mq-pinfunc.h | 623
> > +++++++++++++++++++++++++
> 
> Should this belongs to pinctrl part?

No.  Those pinfunc defines are used by device tree rather than pinctrl
driver.

Shawn
