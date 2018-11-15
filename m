From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Thu, 15 Nov 2018 02:47:43 +0000
Subject: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
In-Reply-To: <AM6PR04MB5863192E246F3ED6F5812E4F8FC30@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20181106131807.29951-1-Zhiqiang.Hou@nxp.com>
 <20181106131807.29951-22-Zhiqiang.Hou@nxp.com>
 <AM6PR04MB58639AF03E732FCF491113728FC50@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <AM6PR04MB57816EE50C61E064E6DC73A684C10@AM6PR04MB5781.eurprd04.prod.outlook.com>
 <AM6PR04MB5863192E246F3ED6F5812E4F8FC30@AM6PR04MB5863.eurprd04.prod.outlook.com>
Message-ID: <AM6PR04MB57813AB3D57856CDD7F5376084DC0@AM6PR04MB5781.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

> -----Original Message-----
> From: Leo Li
> Sent: 2018?11?15? 2:52
> To: Z.q. Hou <zhiqiang.hou@nxp.com>; linux-pci at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; bhelgaas at google.com; robh+dt at kernel.org;
> mark.rutland at arm.com; l.subrahmanya at mobiveil.co.in;
> shawnguo at kernel.org; lorenzo.pieralisi at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>
> Subject: RE: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe controller
> 
> 
> 
> > -----Original Message-----
> > From: Z.q. Hou
> > Sent: Sunday, November 11, 2018 5:48 PM
> > To: Leo Li <leoyang.li@nxp.com>; linux-pci at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; devicetree at vger.kernel.org; linux-
> > kernel at vger.kernel.org; bhelgaas at google.com; robh+dt at kernel.org;
> > mark.rutland at arm.com; l.subrahmanya at mobiveil.co.in;
> > shawnguo at kernel.org; lorenzo.pieralisi at arm.com
> > Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> > <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>
> > Subject: RE: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe
> > controller
> >
> > Hi Leo,
> >
> > Thanks a lot for your comments!
> >
> > > -----Original Message-----
> > > From: Leo Li
> > > Sent: 2018?11?9? 5:29
> > > To: Z.q. Hou <zhiqiang.hou@nxp.com>; linux-pci at vger.kernel.org;
> > > linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> > > linux-kernel at vger.kernel.org; bhelgaas at google.com;
> > > robh+dt at kernel.org; mark.rutland at arm.com;
> > > l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org;
> > > lorenzo.pieralisi at arm.com
> > > Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> > > <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>
> > > Subject: RE: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe
> > > controller
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Z.q. Hou
> > > > Sent: Tuesday, November 6, 2018 7:21 AM
> > > > To: linux-pci at vger.kernel.org;
> > > > linux-arm-kernel at lists.infradead.org;
> > > > devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> > > > bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> > > > l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> > > > <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com
> > > > Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> > > > <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q.
> > > Hou
> > > > <zhiqiang.hou@nxp.com>
> > > > Subject: [PATCH 21/23] dt-bindings: pci: Add NXP LX SoCs PCIe
> > > > controller
> > > >
> > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > >
> > > > Add PCIe controller DT bindings of NXP LX series SoCs.
> > >
> > > I'm not sure if this is a good idea to name this controller LX PCIe controller.
> > > Right now, it could be true that it is only used on LX series SoCs.
> > > But I'm not sure if the LS series will not use this controller or LX
> > > series will only use this controller in the future.
> > >
> > > Since the LX series is still using the layerscape branding, so
> > > probably we should keep using the layerscape-pci.txt and define the
> > > PCIe
> > Gen4 variant?
> >
> > Yes, will add the new PCIe IP bindings to Layerscape-pci.txt.
> >
> > >
> > > Same comment for other places using the LX naming in this driver.
> >
> > Do you have any suggestion about how to name the driver and prefix of
> > structures in the driver?
> 
> Probably something like pcie-layerscape-gen4?

Thanks for your suggestion!
 
Thanks,
Zhiqiang
