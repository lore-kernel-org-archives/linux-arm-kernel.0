From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 13 May 2016 16:00:09 +0200
Subject: [RFC PATCH 0/3] Amlogic: GXBB: Add reset controller
Message-ID: <1463148012-25988-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patchset to add and enable the reset controller driver on GXBB platforms.

Neil Armstrong (3):
  reset: Add support for the Amlogic Meson GXBB Reset Controller
  dt-bindings: reset: Add bindings for the Meson GXBB Reset Controller
  ARM64: dts: amlogic: Enable Reset Controller on GXBB-based platforms

 .../bindings/reset/amlogic,meson-gxbb-reset.txt    |  16 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   6 +
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-meson-gxbb.c                   | 160 +++++++++++++++++++++
 .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   | 160 +++++++++++++++++++++
 6 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson-gxbb-reset.txt
 create mode 100644 drivers/reset/reset-meson-gxbb.c
 create mode 100644 include/dt-bindings/reset/amlogic,meson-gxbb-reset.h

-- 
2.7.0
