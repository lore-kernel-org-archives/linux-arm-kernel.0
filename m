From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 17 Jun 2016 12:35:02 +0200
Subject: [PATCH 0/2] ARM: dts: Add support for the MDM9615
Message-ID: <1466159704-22774-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the Qualcomm MDM9615 in the Sierra Wireless WP8548
Modules, add the MDM9615 DTSI and update its dt-bindings.

This patchset depends on pinctrl [1], clk [2], pmic [3] and arm-soc [4] patchsets.

This patchset is part of a global SoC + Module + Board support for the
Sierra Wireless mangOH Board support with the WP8548 module.

[1] http://lkml.kernel.org/r/1466158535-17962-1-git-send-email-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1466157875-14428-1-git-send-email-narmstrong at baylibre.com
[3] http://lkml.kernel.org/r/1466158929-19524-1-git-send-email-narmstrong at baylibre.com
[4] http://lkml.kernel.org/r/1466159484-21858-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (2):
  ARM: dts: Add MSM9615 dtsi
  dt-bindings: qcom: Add MDM9615 bindings

 Documentation/devicetree/bindings/arm/qcom.txt |   1 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi            | 650 +++++++++++++++++++++++++
 2 files changed, 651 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-mdm9615.dtsi

-- 
1.9.1
