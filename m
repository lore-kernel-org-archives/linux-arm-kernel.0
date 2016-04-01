From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri,  1 Apr 2016 16:42:20 +0200
Subject: [PATCH 0/6] ARM: dts: OXNAS pull request for 4.7
Message-ID: <1459521740-14050-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the ARM device tree pull request for arm-soc related OXNAS platform.

The following changes since commit 1e6d88ccf41c7ef2d6c99aa5e7fb9215aa0e5423:

  Merge tag 'nios2-v4.6-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2 (2016-03-30 20:40:42 -0500)

are available in the git repository at:

  https://github.com/superna9999/linux.git tags/ox810se-arm-dts

for you to fetch changes up to 189e7cc9d357e7b2e96ff758fe9e727cc2a4fe8d:

  ARM: boot: dts: Add Western Digital My Book World Edition device tree (2016-04-01 15:42:31 +0200)

----------------------------------------------------------------
ARM: dts: Add OXNAS Platform Bindings

Changes since original v3 patchset :
- Get rid of PLX Technology
- Add entry into MAINTAINERS files

v3 patchset: http://lkml.kernel.org/r/1458838215-23314-1-git-send-email-narmstrong at baylibre.com

----------------------------------------------------------------
Neil Armstrong (6):
      dt-bindings: irq: arm,versatile-fpga: add compatible string for OX810SE SoC
      dt-bindings: Add Oxford Semiconductor to vendor prefixes
      ARM: boot: dts: Add Oxford Semiconductor OX810SE dtsi
      dt-bindings: Add OXNAS bindings
      dt-bindings: Add Western Digital to vendor prefixes
      ARM: boot: dts: Add Western Digital My Book World Edition device tree

 Documentation/devicetree/bindings/arm/oxnas.txt                                   |   9 +++
 Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt |   2 +-
 Documentation/devicetree/bindings/vendor-prefixes.txt                             |   2 +
 arch/arm/boot/dts/Makefile                                                        |   2 +
 arch/arm/boot/dts/ox810se.dtsi                                                    | 336 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/wd-mbwe.dts                                                     | 112 +++++++++++++++++++++++++++++++
 6 files changed, 462 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 arch/arm/boot/dts/ox810se.dtsi
 create mode 100644 arch/arm/boot/dts/wd-mbwe.dts
