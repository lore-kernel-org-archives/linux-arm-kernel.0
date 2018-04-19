From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 19 Apr 2018 03:23:39 +0000
Subject: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz
 clock source
In-Reply-To: <152410785516.46528.12432838242068784117@swboyd.mtv.corp.google.com>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
 <1521426645-19246-2-git-send-email-Anson.Huang@nxp.com>
 <20180417142203.GM25429@dragon>
 <152410785516.46528.12432838242068784117@swboyd.mtv.corp.google.com>
Message-ID: <AM3PR04MB1315FCBBAFCE808BD35FF2CFF5B50@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Anson Huang
Best Regards!


> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Thursday, April 19, 2018 11:18 AM
> To: Anson Huang <anson.huang@nxp.com>; Shawn Guo
> <shawnguo@kernel.org>
> Cc: mark.rutland at arm.com; devicetree at vger.kernel.org;
> mturquette at baylibre.com; linux-clk at vger.kernel.org; linux at armlinux.org.uk;
> linux-kernel at vger.kernel.org; robh+dt at kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; S.j. Wang <shengjiu.wang@nxp.com>;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz
> clock source
> 
> Quoting Shawn Guo (2018-04-17 07:22:05)
> > On Mon, Mar 19, 2018 at 10:30:45AM +0800, Anson Huang wrote:
> > > On i.MX6SX SabreAuto board, there is external 24MHz clock source for
> > > analog clock2, add this clock source to clock tree.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > changes since V1:
> > >       remove unnecessary clocks container.
> >
> > I understand this is suggested by Fabio, but I'm afraid that it's not
> > going to work with imx_obtain_fixed_clock() call, which is coded to
> > look for clocks under /clocks node.
> >
> 
> Should patch #1 be dropped from clk tree?

If so, I think we should use V1 patch to keep clocks container?
 
Anson.
