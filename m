From: holgerschurig@gmail.com (Holger Schurig)
Date: Mon, 06 Jun 2016 13:04:12 +0200
Subject: [PATCH v2 1/2] ARM: imx6: disable deeper idle states when FEC is
 active w/o HW workaround
In-Reply-To: <VI1PR0401MB1855AA40FA576AF677A68E6FFF5C0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
References: <1464971480-9203-1-git-send-email-l.stach@pengutronix.de>
 <VI1PR0401MB1855AA40FA576AF677A68E6FFF5C0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
Message-ID: <87a8iypoib.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> You just config the gpio irq like below patches:
> bc20a5d6da71 (ARM: dts: imx6qdl-sabreauto: use GPIO_6 for FEC interrupt.)
> 6261c4c8f13e (ARM: dts: imx6qdl-sabrelite: use GPIO_6 for FEC interrupt.)

But this is per-board, e.g. not board-agnostic??!?!   Some board might
have uses GPIO6 for other things and rendered it unusable for this ...
