From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 17 Nov 2015 17:12:25 -0800
Subject: [PATCH 0/4] Add DTS for MSM8996 SoC and MTP
Message-ID: <1447809149-29724-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add the initial dts files for the MSM8996 SoC and
MTP evaluation board.

Stephen Boyd (4):
  devicetree: bindings: Document Kryo cpu
  arm64: dts: Add msm8996 SoC and MTP board support
  arm64: dts: qcom: Add pm8994, pmi8994, pm8004 PMIC skeletons
  arm64: dts: qcom: Add pm8994 gpios and MPPs

 Documentation/devicetree/bindings/arm/cpus.txt |   1 +
 arch/arm64/boot/dts/qcom/Makefile              |   1 +
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts       |  21 ++
 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi      |  30 +++
 arch/arm64/boot/dts/qcom/msm8996.dtsi          | 267 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8004.dtsi           |  19 ++
 arch/arm64/boot/dts/qcom/pm8994.dtsi           |  62 ++++++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi          |  19 ++
 8 files changed, 420 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8004.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm8994.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmi8994.dtsi

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
