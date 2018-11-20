From: minghuan.lian@nxp.com (M.h. Lian)
Date: Tue, 20 Nov 2018 11:33:00 +0000
Subject: [PATCHv2 25/25] arm64: defconfig: Enable
 CONFIG_PCI_LAYERSCAPE_GEN4
In-Reply-To: <20181120092615.11680-26-Zhiqiang.Hou@nxp.com>
References: <20181120092615.11680-1-Zhiqiang.Hou@nxp.com>
 <20181120092615.11680-26-Zhiqiang.Hou@nxp.com>
Message-ID: <HE1PR0401MB2235E2730953E918EFF77F17E8D90@HE1PR0401MB2235.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>

> -----Original Message-----
> From: Z.q. Hou
> Sent: Tuesday, November 20, 2018 5:28 PM
> To: linux-pci at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> bhelgaas at google.com; robh+dt at kernel.org; mark.rutland at arm.com;
> l.subrahmanya at mobiveil.co.in; shawnguo at kernel.org; Leo Li
> <leoyang.li@nxp.com>; lorenzo.pieralisi at arm.com;
> catalin.marinas at arm.com; will.deacon at arm.com
> Cc: Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: [PATCHv2 25/25] arm64: defconfig: Enable
> CONFIG_PCI_LAYERSCAPE_GEN4
> 
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Enable the PCIe Gen4 controller driver for Layerscape SoCs.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - New patch
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ad92daeac585..6b4385f26e85 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -83,6 +83,7 @@ CONFIG_PCI_HOST_THUNDER_PEM=y
> CONFIG_PCI_HOST_THUNDER_ECAM=y  CONFIG_PCIE_ROCKCHIP_HOST=m
> CONFIG_PCI_LAYERSCAPE=y
> +CONFIG_PCI_LAYERSCAPE_GEN4=y
>  CONFIG_PCI_HISI=y
>  CONFIG_PCIE_QCOM=y
>  CONFIG_PCIE_ARMADA_8K=y
> --
> 2.17.1
