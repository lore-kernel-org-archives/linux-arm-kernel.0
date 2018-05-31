From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 31 May 2018 00:59:42 +0000
Subject: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle
 driver
In-Reply-To: <CAOMZO5BJzSHx4zmkMWZVR-Z-y6p-=bMG+WQ2LASOroEdXHdyLA@mail.gmail.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
 <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
 <AM3PR04MB13157285F0D882AD1C189617F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5BJzSHx4zmkMWZVR-Z-y6p-=bMG+WQ2LASOroEdXHdyLA@mail.gmail.com>
Message-ID: <AM3PR04MB1315345C3578D0644B82E8E9F5630@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Thursday, May 31, 2018 8:57 AM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Sascha Hauer <kernel@pengutronix.de>; Fabio
> Estevam <fabio.estevam@nxp.com>; Russell King - ARM Linux
> <linux@armlinux.org.uk>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu
> idle driver
> 
> Hi Anson,
> 
> On Wed, May 30, 2018 at 9:52 PM, Anson Huang <anson.huang@nxp.com>
> wrote:
> 
> >> The removal of this header file seems to be an unrelated change.
> >
> > This header file is no longer needed since no " cpu_is_imx6sl()" used in this
> file.
> 
>  cpu_is_imx6sl() is not defined inside arch/arm/mach-imx/hardware.h header
> file.
 
It is in arch/arm/mach-imx/mxc.h included by hardware.h, it is added by commit
(dee5dee ARM: imx: Add basic msl support for imx6sll), so I removed it since we
no longer need it.

Anson.
