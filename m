From: b.galvani@gmail.com (Beniamino Galvani)
Date: Wed,  1 Oct 2014 23:29:40 +0200
Subject: [PATCH 0/6] ARM: add machine and dts files for Amlogic Meson8
Message-ID: <1412198986-26534-1-git-send-email-b.galvani@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset introduces a machine definition and dts files for
Amlogic Meson8, which is a family of quad-core Cortex-A9 SoCs used in
tablets and set-top boxes.

Beniamino Galvani (6):
  ARM: meson: add meson8 machine definition
  ARM: dts: add dtsi for Amlogic Meson8 SoCs
  ARM: dts: add dts for Tronsmart S89 Elite TV box
  of: add vendor prefix for Tronsmart
  ARM: document Tronsmart compatible properties
  ARM: meson: document meson8 compatible properties

 Documentation/devicetree/bindings/arm/amlogic.txt  |  8 +-
 .../devicetree/bindings/arm/tronsmart.txt          |  7 ++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/meson8-vega-s89e.dts             | 65 ++++++++++++++++
 arch/arm/boot/dts/meson8.dtsi                      | 90 ++++++++++++++++++++++
 arch/arm/mach-meson/Kconfig                        |  5 ++
 arch/arm/mach-meson/meson.c                        |  8 ++
 7 files changed, 181 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tronsmart.txt
 create mode 100644 arch/arm/boot/dts/meson8-vega-s89e.dts
 create mode 100644 arch/arm/boot/dts/meson8.dtsi

-- 
1.9.1
