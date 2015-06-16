From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 13:31:11 -0700
Subject: [PATCH 0/5] Enable SPI ethernet on MSM8960 CDP
Message-ID: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches enable the ks8851 SPI ethernet adapter found on
MSM8960 CDPs.

Stephen Boyd (5):
  ARM: dts: qcom: Replace gpio node with pinctrl node
  ARM: dts: qcom: Add MSM8960 RPM and RPM regulator nodes
  ARM: dts: qcom: Add MSM8960 CDP RPM regulators
  ARM: dts: qcom: Add ks8851 node for wired ethernet
  ARM: qcom_defconfig: Enable options for KS8851 ethernet

 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 302 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi    |  49 +++++-
 arch/arm/configs/qcom_defconfig        |   3 +
 3 files changed, 351 insertions(+), 3 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
