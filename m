From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Thu, 13 Jul 2017 08:34:23 +0000
Subject: [PATCH 1/3] dts: ls2088a: add pcie support
In-Reply-To: <20170713083121.GR3172@dragon>
References: <1499331330-38362-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <20170713081728.GQ3172@dragon>
 <VI1PR0402MB2782E2EB4B0E36EFF55CD5E684AC0@VI1PR0402MB2782.eurprd04.prod.outlook.com>
 <20170713083121.GR3172@dragon>
Message-ID: <VI1PR0402MB2782D24973612C1C0BCD24B184AC0@VI1PR0402MB2782.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2017?7?13? 16:31
> To: Z.q. Hou <zhiqiang.hou@nxp.com>
> Cc: mark.rutland at arm.com; devicetree at vger.kernel.org;
> catalin.marinas at arm.com; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>; will.deacon at arm.com;
> robh+dt at kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/3] dts: ls2088a: add pcie support
> 
> On Thu, Jul 13, 2017 at 08:27:47AM +0000, Z.q. Hou wrote:
> > Hi Shawn,
> >
> > Thanks for your comments!
> >
> > > -----Original Message-----
> > > From: Shawn Guo [mailto:shawnguo at kernel.org]
> > > Sent: 2017?7?13? 16:18
> > > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > > Cc: linux-arm-kernel at lists.infradead.org;
> > > devicetree at vger.kernel.org;
> > > robh+dt at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com;
> > > will.deacon at arm.com; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>
> > > Subject: Re: [PATCH 1/3] dts: ls2088a: add pcie support
> > >
> > > On Thu, Jul 06, 2017 at 04:55:28PM +0800, Zhiqiang Hou wrote:
> > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > >
> > > > The physical memory map address and CCSR registers map address are
> > > > different between LS2088A and other LS2080A series SoCs.
> > > >
> > > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > > > b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > > > index 5c695c6..7d26531 100644
> > > > --- a/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi
> > > > @@ -134,6 +134,7 @@
> > > >  };
> > > >
> > > >  &pcie1 {
> > > > +	compatible = "fsl,ls2088a-pcie", "snps,dw-pcie";
> > >
> > > I do not see "fsl,ls2088a-pcie" in either bindings doc or kernel driver.
> > >
> >
> > I submitted the DT node patch and driver code patch separately, see the
> driver patch:
> > https://patchwork.kernel.org/patch/9827915/
> 
> Send me the dts changes after bindings and driver patch land on mainline.

Sure, thanks a lot!

- Zhiqiang
