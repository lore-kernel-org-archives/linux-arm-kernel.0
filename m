From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 19 Sep 2018 06:10:16 +0000
Subject: [PATCH 0/4] Add i.MX6ULZ SoC support
In-Reply-To: <e82e2894-2a0d-0084-913c-b7c6d966fc13@i2se.com>
References: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
 <e82e2894-2a0d-0084-913c-b7c6d966fc13@i2se.com>
Message-ID: <DB3PR0402MB39162EA4FD240720276A4482F51C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stefan

Anson Huang
Best Regards!


> -----Original Message-----
> From: Stefan Wahren <stefan.wahren@i2se.com>
> Sent: Tuesday, September 18, 2018 3:38 PM
> To: Anson Huang <anson.huang@nxp.com>; robh+dt at kernel.org;
> mark.rutland at arm.com; shawnguo at kernel.org; s.hauer at pengutronix.de;
> kernel at pengutronix.de; Fabio Estevam <fabio.estevam@nxp.com>;
> linux at armlinux.org.uk; mturquette at baylibre.com; sboyd at kernel.org; Jacky
> Bai <ping.bai@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-clk at vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH 0/4] Add i.MX6ULZ SoC support
> 
> Hi Anson,
> 
> Am 18.09.2018 um 08:19 schrieb Anson Huang:
> > This patch set adds i.MX6ULZ SoC support, i.MX6ULZ is a new SoC of
> > i.MX6 family, compared to i.MX6ULL, it removes below modules:
> >
> >     - UART5/UART6/UART7/UART8;
> >     - PWM5/PWM6/PWM7/PWM8;
> >     - eCSPI3/eCSPI4;
> >     - CAN1/CAN2;
> >     - FEC1/FEC2;
> >     - I2C3/I2C4;
> >     - EPIT2;
> >     - LCDIF;
> >     - GPT2;
> >     - TSC;
> >
> > And i.MX6ULZ has same soc_id as i.MX6ULL, but SRC_SBMR2 bit[6] is to
> > differentiate i.MX6ULZ from i.MX6ULL, 1'b1 means i.MX6ULZ and
> > 1'b0 means i.MX6ULL. i.MX6ULZ reuse most of i.MX6UL/i.MX6ULL code,
> > just add the new CPU type and remove those non-exist modules from dtb.
> >
> > Anson Huang (4):
> >   ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support
> >   ARM: imx: add i.mx6ulz msl support
> >   clk: imx6ul: add i.mx6ulz support
> >   dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
> >
> >
> 
> i recommend the following patch order:
> ARM: imx: add i.mx6ulz msl support
> clk: imx6ul: add i.mx6ulz support
> dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
> ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support
> 
> Stefan
 
Thanks, I resend the V2 patch set with the patch order you recommended.

Anson.
