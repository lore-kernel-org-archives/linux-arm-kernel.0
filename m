From: leoyang.li@nxp.com (Leo Li)
Date: Fri, 3 Nov 2017 17:06:58 +0000
Subject: [PATCH 0/3] dts: Add the property of IB and OB
In-Reply-To: <20171103093115.14915-1-xiaowei.bao@nxp.com>
References: <20171103093115.14915-1-xiaowei.bao@nxp.com>
Message-ID: <AM4PR0401MB1699C33E678BB7DD027307568F5D0@AM4PR0401MB1699.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Bao Xiaowei [mailto:xiaowei.bao at nxp.com]
> Sent: Friday, November 03, 2017 4:31 AM
> To: robh+dt at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com;
> will.deacon at arm.com; bhelgaas at google.com; shawnguo at kernel.org;
> Madalin-cristian Bucur <madalin.bucur@nxp.com>; Sumit Garg
> <sumit.garg@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; hongtao.jia at nxp.com;
> Andy Tang <andy.tang@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> kishon at ti.com; jingoohan1 at gmail.com; pbrobinson at gmail.com;
> songxiaowei at hisilicon.com; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> pci at vger.kernel.org; linuxppc-dev at lists.ozlabs.org; Z.q. Hou
> <zhiqiang.hou@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>
> Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
> Subject: [PATCH 0/3] dts: Add the property of IB and OB

When you send a v2 series, please include v2 in the title of all patches like "[PATCH v2 0/3]"...

Also the title of this summary email should really be the summary of all 3 patches like "Adding PCIe EP support to ls1046a".

-Leo


> 
> Depend on
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fpatchw
> ork.ozlabs.org%2Fpatch%2F815382%2F&data=02%7C01%7Cleoyang.li%40nxp.c
> om%7C7db015020c8a414f57e708d522a03165%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C636452993777387982&sdata=19Fmzg%2FOJGl%2Bgizv
> xfY1yELlFgWKRuZ%2FVNbx49yz2Wk%3D&reserved=0
> 
> Bao Xiaowei (3):
>   ARMv8: dts: ls1046a: add the property of IB and OB
>   ARMv8: layerscape: add the pcie ep function support
>   ARMv8: pcie: make the DWC EP driver support for layerscape
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   6 ++
>  drivers/pci/dwc/Kconfig                        |   1 +
>  drivers/pci/dwc/pci-layerscape.c               | 122 +++++++++++++++++++++++--
>  3 files changed, 123 insertions(+), 6 deletions(-)
> 
> --
> 2.14.1
