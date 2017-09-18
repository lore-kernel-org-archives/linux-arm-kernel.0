From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Mon, 18 Sep 2017 17:32:20 +0800
Subject: [PATCHv3 0/3] arm64: dts: add ls2088a and 1088a pcie DT nodes
Message-ID: <20170918093223.33364-1-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add GICv3 ITS DT node for ls1088a, because the PCIe nodes must
have a msi-parent.

Hou Zhiqiang (3):
  arm64: dts: ls2088a: add pcie support
  arm64: dts: ls1088a: add gicv3 ITS DT node
  arm64: dts: ls1088a: add PCIe controller DT nodes

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 82 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  4 ++
 2 files changed, 86 insertions(+)

-- 
2.14.1
