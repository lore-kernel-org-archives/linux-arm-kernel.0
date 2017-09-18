From: zhiqiang.hou@nxp.com (Z.q. Hou)
Date: Mon, 18 Sep 2017 09:52:17 +0000
Subject: [PATCHv3 0/3] arm64: dts: add ls2088a and 1088a pcie DT nodes
In-Reply-To: <20170918093223.33364-1-Zhiqiang.Hou@nxp.com>
References: <20170918093223.33364-1-Zhiqiang.Hou@nxp.com>
Message-ID: <AM5PR0402MB2771422484B12A966BC06B9D84630@AM5PR0402MB2771.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

The LS1088 and LS2088 driver patch set has been applied to Linux-next.

> -----Original Message-----
> From: Zhiqiang Hou [mailto:Zhiqiang.Hou at nxp.com]
> Sent: 2017?9?18? 17:32
> To: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> robh+dt at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com;
> will.deacon at arm.com; shawnguo at kernel.org; Prabhakar Kushwaha
> <prabhakar.kushwaha@nxp.com>
> Cc: Z.q. Hou <zhiqiang.hou@nxp.com>
> Subject: [PATCHv3 0/3] arm64: dts: add ls2088a and 1088a pcie DT nodes
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Add GICv3 ITS DT node for ls1088a, because the PCIe nodes must have a
> msi-parent.
> 
> Hou Zhiqiang (3):
>   arm64: dts: ls2088a: add pcie support
>   arm64: dts: ls1088a: add gicv3 ITS DT node
>   arm64: dts: ls1088a: add PCIe controller DT nodes
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 82
> ++++++++++++++++++++++++++
> arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  4 ++
>  2 files changed, 86 insertions(+)
> 
> --
> 2.14.1

Thanks,
Zhiqiang
