From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Wed, 1 Nov 2017 11:40:13 +0800
Subject: [PATCH 0/2] arm64: dts: Add ls1088a DSPI device tree nodes
Message-ID: <20171101034015.41114-1-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

LS1088A reuse LS2085A DSPI driver, this patchset just adds device tree
nodes and adds compatible entry to documentation.

Hou Zhiqiang (2):
  arm64: dts: ls1088a: add DT nodes for DSPI support
  Documentation: fsl: dspi: Add a compatible string for ls1088a DSPI

 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  1 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts  | 28 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 13 ++++++++++
 3 files changed, 42 insertions(+)

-- 
2.14.1
