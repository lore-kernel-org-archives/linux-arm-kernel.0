From: carlo@caione.org (Carlo Caione)
Date: Thu,  1 Oct 2015 13:38:30 +0200
Subject: [PATCH 0/4] Add support for Amlogic Meson8b and couple of boards
Message-ID: <1443699514-11590-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

A patchset sitting in my personal repo since forever. It adds the basic support
for Amlogic Meson8B SoCs and two common boards: Hardkernel Odroid-C1 and Tronfy
MXQ.

Carlo Caione (4):
  of: documentation: Add vedor prefix for Tronfy
  of: documentation: add bindings documentation for Meson8b
  ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards
  ARM: meson: Enable Meson8b SoCs

 Documentation/devicetree/bindings/arm/amlogic.txt  |   6 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/meson8b-mxq.dts                  |  67 ++++++++
 arch/arm/boot/dts/meson8b-odroidc1.dts             |  67 ++++++++
 arch/arm/boot/dts/meson8b.dtsi                     | 186 +++++++++++++++++++++
 arch/arm/mach-meson/Kconfig                        |   5 +
 arch/arm/mach-meson/meson.c                        |   1 +
 8 files changed, 336 insertions(+)
 create mode 100644 arch/arm/boot/dts/meson8b-mxq.dts
 create mode 100644 arch/arm/boot/dts/meson8b-odroidc1.dts
 create mode 100644 arch/arm/boot/dts/meson8b.dtsi

-- 
1.9.1
