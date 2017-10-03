From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  3 Oct 2017 17:29:43 +0200
Subject: [PATCH v2 0/2] ARM64: Add Vega S96 board support
Message-ID: <1507044585-20117-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the Tronsmart Vega S96 TV Box based
on the Q200 Amlogic Reference design.

Changes since v1 at [1] :
 - Add acks
 - Cleanup external_phy node

[1]  https://lkml.kernel.org/r/1505822748-23431-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (2):
  ARM64: dts: meson-gxm: Add Vega S96 board
  dt-bindings: arm: amlogic: Add Tronsmart Vega S96 binding

 Documentation/devicetree/bindings/arm/amlogic.txt  |  1 +
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts | 38 ++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts

-- 
2.7.4
