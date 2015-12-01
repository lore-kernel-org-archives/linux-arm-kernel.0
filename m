From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 30 Nov 2015 17:25:20 -0800
Subject: [PATCH v3 0/3] Remove ARCH_MSM* configs
Message-ID: <1448933123-9843-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series allows us to remove the ARCH_MSM* configs that live
in mach-qcom/Kconfig. They're mostly proxy configs for user selectable
clocksource configurations anyway.

Changes from v2:
 * Renamed config in patch 1 to QCOM_ARCH_A_FAMILY to be less confusing

Changes from v1:
 * Patch 1 replaced with one that moves config to mach-qcom/Kconfig
 * Applied Arnd's acks to patches 2 and 3

Stephen Boyd (3):
  ARM: qcom: Make an option for qcom 'a-family' platforms
  ARM: qcom_defconfig: Enable HAVE_ARM_ARCH_TIMER
  ARM: qcom: Drop ARCH_MSM* configs

 arch/arm/Makefile               |  3 +--
 arch/arm/configs/qcom_defconfig |  1 +
 arch/arm/mach-qcom/Kconfig      | 17 +++++++++--------
 3 files changed, 11 insertions(+), 10 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
