From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 30 May 2018 22:06:11 -0300
Subject: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle
 driver
In-Reply-To: <AM3PR04MB1315345C3578D0644B82E8E9F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
 <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
 <AM3PR04MB13157285F0D882AD1C189617F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BJzSHx4zmkMWZVR-Z-y6p-=bMG+WQ2LASOroEdXHdyLA@mail.gmail.com>
 <AM3PR04MB1315345C3578D0644B82E8E9F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5DB4YrU=JiKe0HAqQsr82iU=Fac3or++bwddrBVAZ+Cfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 9:59 PM, Anson Huang <anson.huang@nxp.com> wrote:

> It is in arch/arm/mach-imx/mxc.h included by hardware.h, it is added by commit
> (dee5dee ARM: imx: Add basic msl support for imx6sll), so I removed it since we
> no longer need it.

Ah, OK: "mxc.h" is included by "hardware.h". Got it!
