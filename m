From: anson.huang@nxp.com (Anson Huang)
Date: Tue, 9 Jan 2018 10:10:09 +0000
Subject: [PATCH V3 1/2] clk: imx: imx7d: add the snvs clock
In-Reply-To: <20180109094348.GG26312@b29396-OptiPlex-7040>
References: <1515489651-13488-1-git-send-email-Anson.Huang@nxp.com>
 <20180109094348.GG26312@b29396-OptiPlex-7040>
Message-ID: <AM3PR04MB1315A6E9A645EC6256914285F5100@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang


> -----Original Message-----
> From: Dong Aisheng [mailto:dongas86 at gmail.com]
> Sent: 2018-01-09 5:44 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Horia Geant? <horia.geanta@nxp.com>; Aymen Sghaier
> <aymen.sghaier@nxp.com>; herbert at gondor.apana.org.au;
> davem at davemloft.net; robh+dt at kernel.org; mark.rutland at arm.com;
> shawnguo at kernel.org; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; linux at armlinux.org.uk;
> mturquette at baylibre.com; sboyd at codeaurora.org; Adriana Reus
> <adriana.reus@nxp.com>; stefan at agner.ch; linux-crypto at vger.kernel.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-clk at vger.kernel.org; dl-linux-imx <linux-
> imx at nxp.com>
> Subject: Re: [PATCH V3 1/2] clk: imx: imx7d: add the snvs clock
> 
> On Tue, Jan 09, 2018 at 05:20:50PM +0800, Anson Huang wrote:
> > According to the i.MX7D Reference Manual, SNVS block has a clock gate,
> > accessing SNVS block would need this clock gate to be enabled, add it
> > into clock tree so that SNVS module driver can operate this clock
> > gate.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> You missed the last round review tags.
> 
> Regards
> Dong Aisheng


Thanks for reminder, already sent out a V4 patch set to add tags.

Anson.
