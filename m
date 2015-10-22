From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 22 Oct 2015 11:13:47 -0700
Subject: [PATCH 0/4] Sony Xperia Z dts
Message-ID: <1445537631-29055-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series starts by adding hwspinlock, smem, gsbi5 and cleans up the
8064 regulator definitions.

Based on this it adds the necessary nodes for booting the Sony Xperia Z
(APQ8064 based) to userspace, with UART, eMMC, uSD, USB gadget and hw
buttons.

Bjorn Andersson (4):
  ARM: dts: qcom: apq8064: Add hwmutex and SMEM nodes
  ARM: dts: qcom: apq8064: Declare all pm8921 regulators
  ARM: dts: qcom: apq8064: Introduce gsbi5 and gsbi5 serial node
  ARM: dts: qcom: apq8064: Introduce Sony Xperia Z dts

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |  16 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  20 +-
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts | 436 +++++++++++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  97 +++++
 5 files changed, 552 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts

-- 
2.4.2
