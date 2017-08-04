From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Fri, 4 Aug 2017 14:44:03 +0800
Subject: [PATCHv2 0/3] dts: add ls2088a and 1088a pcie DT nodes
Message-ID: <1501829046-3761-1-git-send-email-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add GICv3 ITS DT node for ls1088a, because the PCIe nodes must
have a msi-parent.

Hou Zhiqiang (3):
  dts: ls2088a: add pcie support
  dts: ls1088a: add gicv3 ITS DT node
  dts: ls1088a: add PCIe controller DT nodes

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 81 ++++++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi |  4 ++
 2 files changed, 85 insertions(+)

-- 
2.1.0.27.g96db324
