From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 14:31:43 -0700
Subject: [PATCH 00/10] Use stdout-path on qcom boards
Message-ID: <1434490313-13905-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches convert the qcom dts files to use serial aliases
and the stdout-path property so that we don't have to put the
console on the kernel commandline.

Cc: Mike Rapoport <mike.rapoport@gmail.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tim Bird <tim.bird@sonymobile.com>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Mathieu Olivari <mathieu@codeaurora.org>

Stephen Boyd (10):
  ARM: dts: qcom: Label serial nodes for aliasing and stdout-path
  ARM: dts: qcom: apq8064-cm-qs600: Use stdout-path
  ARM: dts: qcom: apq8064-ifc6410: Use stdout-path
  ARM: dts: qcom: apq8074-dragonboard: Use stdout-path
  ARM: dts: qcom: apq8084-ifc6540: Use stdout-path
  ARM: dts: qcom: apq8084-mtp: Use stdout-path
  ARM: dts: qcom: ipq8064-ap148: Use stdout-path
  ARM: dts: qcom: msm8660-surf: Use stdout-path
  ARM: dts: qcom: msm8960-cdp: Use stdout-path
  ARM: dts: qcom: msm8974-sony-xperia-honami: Use stdout-path

 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts           | 8 ++++++++
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts            | 4 ++++
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts        | 8 ++++++++
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts            | 8 ++++++++
 arch/arm/boot/dts/qcom-apq8084-mtp.dts                | 8 ++++++++
 arch/arm/boot/dts/qcom-apq8084.dtsi                   | 2 +-
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts              | 8 ++++++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi                   | 2 +-
 arch/arm/boot/dts/qcom-msm8660-surf.dts               | 8 ++++++++
 arch/arm/boot/dts/qcom-msm8660.dtsi                   | 2 +-
 arch/arm/boot/dts/qcom-msm8960-cdp.dts                | 8 ++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi                   | 2 +-
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts | 8 ++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi                   | 2 +-
 14 files changed, 73 insertions(+), 5 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
