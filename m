From: anson.huang@nxp.com (Anson Huang)
Date: Sun, 6 May 2018 06:10:11 +0000
Subject: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
 screen support
In-Reply-To: <CAOMZO5A7bf1qcHrWjM1mr31Nkz+oDJ=fQo3rjksp1YY-HhPM9A@mail.gmail.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
 <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5A7bf1qcHrWjM1mr31Nkz+oDJ=fQo3rjksp1YY-HhPM9A@mail.gmail.com>
Message-ID: <AM3PR04MB1315E5B2A6C1DDCC6C279715F5840@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

Anson Huang
Best Regards!


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Saturday, May 5, 2018 11:18 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <kernel@pengutronix.de>; Fabio Estevam <fabio.estevam@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Haibo Chen <haibo.chen@freescale.com>; Andy Duan
> <fugang.duan@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>; Robin Gong
> <yibin.gong@nxp.com>; dl-linux-imx <linux-imx@nxp.com>; moderated
> list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> <linux-arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; linux-kernel
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
> screen support
> 
> On Sat, May 5, 2018 at 5:29 AM, Anson Huang <Anson.Huang@nxp.com>
> wrote:
> 
> >  &iomuxc {
> > +       pinctrl_egalax_int: egalax-intgrp {
> > +               fsl,pins = <
> > +                       MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22
> 0x80000000
> 
> Please avoid using 0x80000000 and use the real IOMUX value instead.
 
Will use the expected pad settings in next version. Thanks.

Anson.
