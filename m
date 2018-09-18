From: anson.huang@nxp.com (Anson Huang)
Date: Tue, 18 Sep 2018 01:15:02 +0000
Subject: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz
 operating point
In-Reply-To: <DB3PR0402MB3916249305E241849A32DC05F51B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
 <d989e700-0cf1-607a-b333-bdead49ae813@i2se.com>
 <DB3PR0402MB3916249305E241849A32DC05F51B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Message-ID: <DB3PR0402MB3916936F80C14D00F5D07966F51D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stefan

Anson Huang
Best Regards!


> -----Original Message-----
> From: Anson Huang
> Sent: Wednesday, September 12, 2018 4:30 PM
> To: Stefan Wahren <stefan.wahren@i2se.com>; shawnguo at kernel.org;
> s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: RE: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz
> operating point
> 
> Hi, Stefan
> 
> Anson Huang
> Best Regards!
> 
> 
> > -----Original Message-----
> > From: Stefan Wahren <stefan.wahren@i2se.com>
> > Sent: Wednesday, September 12, 2018 4:28 PM
> > To: Anson Huang <anson.huang@nxp.com>; shawnguo at kernel.org;
> > s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> > <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> > linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> > linux-kernel at vger.kernel.org
> > Cc: dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for
> > 900MHz operating point
> >
> > Hi Anson,
> >
> > Am 12.09.2018 um 10:13 schrieb Anson Huang:
> > > Update VDD_SOC voltage to 1.25V for 900MHz operating point according
> > > to datasheet Rev. 1.3, 08/2018, 25mV is added to the minimum allowed
> > > values to cover power supply ripple.
> >
> > is there a reason why the new datasheet isn't published yet?
> 
> We just got this new datasheet recently, it will be published soon.
> 
> Anson 

The v1.3 datasheet has been published. Please check it from NXP website, thanks.

Anson.

> 
> >
> > Regards
> > Stefan
