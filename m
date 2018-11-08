From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu,  8 Nov 2018 14:53:48 +0100
Subject: [PATCH 0/4] arm64: dts: meson-axg: enable SCPI
Message-ID: <20181108135352.8459-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this patchset is to enable SCPI (dvfs and hwmon) the axg
platform. The first patches in this series fix a few issues to acheive
this.

Jerome Brunet (4):
  arm64: dts: meson-axg: fix mailbox address
  arm64: dts: meson-axg: correct sram shared mem unit-address
  Documentation: bindings: Add missing Amlogic SCPI sensor bindings
  arm64: dts: meson-axg: enable SCPI

 .../devicetree/bindings/arm/amlogic,scpi.txt  |  7 ++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 34 ++++++++++++++++---
 2 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.19.1
