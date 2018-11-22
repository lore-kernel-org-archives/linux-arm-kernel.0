From: xiaowei.bao@nxp.com (Xiaowei Bao)
Date: Thu, 22 Nov 2018 02:33:29 +0000
Subject: [PATCHv4 0/3] dts: Add the property of IB and OB
In-Reply-To: <20181120173021.GA29331@e107981-ln.cambridge.arm.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
 <20181120173021.GA29331@e107981-ln.cambridge.arm.com>
Message-ID: <HE1PR04MB14978C967CFAE17815FF1CC8F5DB0@HE1PR04MB1497.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

Yes, these series patches can drop, thanks a lot. 

Best regards
Xiaowei

-----Original Message-----
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> 
Sent: 2018?11?21? 1:31
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Cc: robh+dt at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com; will.deacon at arm.com; bhelgaas at google.com; shawnguo at kernel.org; Madalin-cristian Bucur <madalin.bucur@nxp.com>; sumit.garg at nxp.com; Y.B. LU <yangbo.lu@nxp.com>; hongtao.jia at nxp.com; Andy Tang <andy.tang@nxp.com>; Leo Li <leoyang.li@nxp.com>; kishon at ti.com; jingoohan1 at gmail.com; pbrobinson at gmail.com; songxiaowei at hisilicon.com; devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-pci at vger.kernel.org; linuxppc-dev at lists.ozlabs.org; Z.q. Hou <zhiqiang.hou@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>
Subject: Re: [PATCHv4 0/3] dts: Add the property of IB and OB

On Fri, Nov 10, 2017 at 11:48:44AM +0800, Bao Xiaowei wrote:
> Depend on 
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fpatc
> hwork.ozlabs.org%2Fpatch%2F815382%2F&amp;data=02%7C01%7Cxiaowei.bao%40
> nxp.com%7C675188594567418ccf6a08d64f0de9f5%7C686ea1d3bc2b4c6fa92cd99c5
> c301635%7C0%7C0%7C636783318517192971&amp;sdata=HilLT%2B5T%2B%2Bubpxra8
> l54ZViEFN7SBCf4vDB8zDMWUd4%3D&amp;reserved=0
> 
> Bao Xiaowei (3):
>   ARMv8: dts: ls1046a: add the property of IB and OB
>   ARMv8: layerscape: add the pcie ep function support
>   ARMv8: pcie: make the DWC EP driver support for layerscape
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |   6 ++
>  drivers/pci/dwc/Kconfig                        |   1 +
>  drivers/pci/dwc/pci-layerscape.c               | 121 +++++++++++++++++++++++--
>  3 files changed, 121 insertions(+), 7 deletions(-)

Can I drop this series from the linux-pci patch queue ? I reckon it is superseded by:

https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.ozlabs.org%2Fpatch%2F992928%2F&amp;data=02%7C01%7Cxiaowei.bao%40nxp.com%7C675188594567418ccf6a08d64f0de9f5%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636783318517192971&amp;sdata=i3U%2F7uT%2Fno%2FSGVc6VD1gg7Ybn0zV%2F%2B8A9698QHfuoTo%3D&amp;reserved=0

but I wanted to make sure that's the case, I really can't follow the version numbering so I am asking.

Thanks,
Lorenzo
