From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 20 Nov 2017 18:23:52 +0800
Subject: [RESEND PATCH v3 0/2] dt: add pinctrl driver for Meson-AXG SoC
Message-ID: <20171120102354.5354-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is DT part patchset for adding pinctrl support for
the Amlogic's Meson-AXG SoC.
  
Changes since v2 at [2]:
  -- Resend this patch series due to fail to send patch [2/2]

Changes since v1 at [1]:
  -- Separate DT part patches
  -- Add Neil Armstrong's Ack

[2]
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005390.html

[1] 
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005270.html
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005271.html
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005272.html
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005273.html
http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005274.html

Xingyu Chen (2):
  documentation: Add compatibles for Amlogic Meson AXG pin controllers
  ARM64: dts: meson-axg: add pinctrl DT info for Meson-AXG SoC

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |  2 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 44 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)

-- 
2.15.0
