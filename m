From: marek@goldelico.com (Marek Belisko)
Date: Mon, 14 Jul 2014 22:20:23 +0200
Subject: [PATCH 0/5] Add gta04 board variants
Message-ID: <1405369228-27197-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series completes the GTA04 device tree to describe all hardware
components that are on the different variants of the GTA04 boards.

Marek Belisko (5):
  arm: dts: omap3-gta04: Add missing nodes to fully describe gta04 board
  arm: dts: omap3-gta04: Rename gta04.dts to gta04.dtsi and add a4 model
  arm: dts: Add gta04a3 model
  arm: dts: Add gta04+b2 model bindings
  arm: dts: Add gta04+b3 model bindings

 arch/arm/boot/dts/Makefile           |   5 +-
 arch/arm/boot/dts/omap3-gta04+b2.dts |  99 +++++
 arch/arm/boot/dts/omap3-gta04+b3.dts | 118 ++++++
 arch/arm/boot/dts/omap3-gta04.dts    | 341 -----------------
 arch/arm/boot/dts/omap3-gta04.dtsi   | 722 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-gta04a3.dts  |  48 +++
 arch/arm/boot/dts/omap3-gta04a4.dts  |  13 +
 7 files changed, 1004 insertions(+), 342 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-gta04+b2.dts
 create mode 100644 arch/arm/boot/dts/omap3-gta04+b3.dts
 delete mode 100644 arch/arm/boot/dts/omap3-gta04.dts
 create mode 100644 arch/arm/boot/dts/omap3-gta04.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-gta04a3.dts
 create mode 100644 arch/arm/boot/dts/omap3-gta04a4.dts

-- 
1.9.1
