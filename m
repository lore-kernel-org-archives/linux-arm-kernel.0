From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 15:07:39 +0200
Subject: [PATCH v2 0/2] ARM: dts: Add support for the MDM9615
Message-ID: <1471525661-2563-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support the Qualcomm MDM9615 in the Sierra Wireless WP8548
Modules, add the MDM9615 DTSI and update its dt-bindings.

This patchset depends on pinctrl [merged], clk [merged], pmic [1] and arm-soc [merged] patchsets.

This patchset is part of a global SoC + Module + Board support for the
Sierra Wireless mangOH Board support with the WP8548 module.

[1] http://lkml.kernel.org/r/1470921406-18468-1-git-send-email-narmstrong at baylibre.com

Changes since v1 at : http://lkml.kernel.org/r/1466159704-22774-1-git-send-email-narmstrong at baylibre.com
 - Added cxo_board clock node
 - Added secondary pm8921 compatibles
 - Dropped corner regulator
 - Dropped USB nodes

Neil Armstrong (2):
  ARM: dts: Add MDM9615 dtsi
  dt-bindings: qcom: Add MDM9615 bindings

 Documentation/devicetree/bindings/arm/qcom.txt |   1 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi            | 555 +++++++++++++++++++++++++
 2 files changed, 556 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-mdm9615.dtsi

-- 
1.9.1
