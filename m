From: b.galvani@gmail.com (Beniamino Galvani)
Date: Tue, 20 Jan 2015 00:22:56 +0100
Subject: [PATCH 0/3] ARM: meson: add support for MINIX NEO-X8
Message-ID: <1421709779-25691-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for MINIX NEO-X8, a digital media player
based on a Amlogic S802 (Meson8) SoC. It depends on the pinctrl
support for Meson8 submitted here:

  https://lkml.org/lkml/2015/1/17/87

Beniamino Galvani (3):
  of: Add vendor prefix for MINIX
  of: Define board compatible for MINIX NEO-X8
  ARM: dts: meson: add DTS file for MINIX NEO-X8

 Documentation/devicetree/bindings/arm/amlogic.txt  |   4 +
 .../devicetree/bindings/arm/geniatech.txt          |   5 -
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/meson8-minix-neo-x8.dts          | 128 +++++++++++++++++++++
 5 files changed, 134 insertions(+), 5 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/geniatech.txt
 create mode 100644 arch/arm/boot/dts/meson8-minix-neo-x8.dts

-- 
2.1.4
