From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 12 Sep 2016 22:09:58 +0200 (CEST)
Subject: [PATCH v2 3/4] ARM: dts: imx23: Fix build warnings with W=1
In-Reply-To: <1473103670-15922-3-git-send-email-festevam@gmail.com>
References: <1473103670-15922-1-git-send-email-festevam@gmail.com>
 <1473103670-15922-3-git-send-email-festevam@gmail.com>
Message-ID: <494364123.109779.ea238904-0649-44f2-b379-3c307984c54c.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Fabio Estevam <festevam@gmail.com> hat am 5. September 2016 um 21:27
> geschrieben:
> 
> 
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Fix the following build warnings with W=1:
> 
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but
> no unit name
> 
> While at it, also pass the 'device_type' property as recommended by the
> ePAPR specification.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Patch 1 and 3 works for my Olinuxino board.

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
