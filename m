From: marek@goldelico.com (Marek Belisko)
Date: Mon, 28 Jul 2014 21:53:30 +0200
Subject: [PATCH 0/3] arm: dts: omap3-gta04: Move common parts to include file
 and add models
Message-ID: <1406577213-9642-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small patchset move omap3-gta04.dts to omap3-gta04.dtsi which then share
common parts with a3,a4 and a5 models. Models a3 and a5 have only small additions
to gta04a4 model.

Marek Belisko (3):
  arm: dts: omap3-gta04: Rename gta04.dts to gta04.dtsi and add a4 model
  arm: dts: Add gta04a3 model
  arm: dts: Add gta04a5 model

 arch/arm/boot/dts/Makefile                         |  4 +-
 .../boot/dts/{omap3-gta04.dts => omap3-gta04.dtsi} |  0
 arch/arm/boot/dts/omap3-gta04a3.dts                | 48 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-gta04a4.dts                | 13 ++++++
 arch/arm/boot/dts/omap3-gta04a5.dts                | 17 ++++++++
 5 files changed, 81 insertions(+), 1 deletion(-)
 rename arch/arm/boot/dts/{omap3-gta04.dts => omap3-gta04.dtsi} (100%)
 create mode 100644 arch/arm/boot/dts/omap3-gta04a3.dts
 create mode 100644 arch/arm/boot/dts/omap3-gta04a4.dts
 create mode 100644 arch/arm/boot/dts/omap3-gta04a5.dts

-- 
1.9.1
-
