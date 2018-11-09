From: vkoul@kernel.org (Vinod Koul)
Date: Fri,  9 Nov 2018 15:13:59 +0530
Subject: [PATCH v5 00/18]  arm64: dts: qcom: qcs404: Add Device tree nodes
Message-ID: <20181109094417.12109-1-vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for various nodes for QCS404-EVB.

Based on v4.20-rc1

Changes in v5:
 - Fix warns reported with W=12
 - Fix comments by Rob

Changes in v4:
 - correct the v3 post (sent wrong branch)

Changes in v3:
 - Make the DTS files sorted alphabetcially and by node addresses
 - Add reviewed by from Bjorn
 - Split out the DTS files for EVB 1000 and EVB 4000 boards and add common
   evb dts files for common part

Changes in v2:
 Fix cpu binding

Bjorn Andersson (7):
  arm64: dts: qcom: qcs404: Add reserved-memory regions
  arm64: dts: qcom: qcs404: Add RPM GLINK related nodes
  arm64: dts: qcom: qcs404: Add PMS405 RPM regulators
  arm64: dts: qcom: qcs404: Add TLMM pinctrl node
  arm64: dts: qcom: qcs404: Add sdcc1 node
  arm64: dts: qcom: qcs404: Add scm firmware node
  arm64: dts: qcom: qcs404: Add remoteproc nodes

Vinod Koul (11):
  arm64: dts: qcom: qcs404: add base dts files
  arm64: dts: qcom: qcs404-evb: add dts files for EVBs
  arm64: dts: qcom: qcs404: add smp2p nodes
  arm64: dts: qcom: pms405: add spmi node
  arm64: dts: qcom: qcs404: add spmi node
  arm64: dts: qcom: pms405: add rtc node
  arm64: dts: qcom: pms405: add gpios
  arm64: dts: qcom: qcs404: add prng-ee node
  arm64: dts: qcom: qcs404: Add BAM DMA node
  arm64: dts: qcom: qcs404: Use BAM DMA for serial uart2
  arm64: dts: qcom: pms405: Add pon and pwrkey nodes

 arch/arm64/boot/dts/qcom/Makefile            |   2 +
 arch/arm64/boot/dts/qcom/pms405.dtsi         |  55 +++
 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts |  11 +
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts |  11 +
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi     | 188 ++++++++++
 arch/arm64/boot/dts/qcom/qcs404.dtsi         | 490 +++++++++++++++++++++++++++
 6 files changed, 757 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pms405.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404.dtsi

-- 
2.14.4
