From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 25 Apr 2016 19:39:31 +0200
Subject: [PULL REQUEST v2] ARM: dts: OXNAS pull request for 4.7
Message-ID: <1461605971-19866-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the ARM device tree pull request for arm-soc related OXNAS platform.

The following changes since commit c3b46c73264b03000d1e18b22f5caf63332547c9:

  Linux 4.6-rc4 (2016-04-17 19:13:32 -0700)

are available in the git repository at:

  https://github.com/superna9999/linux.git tags/ox810se-arm-dt-v4.6-rc4

for you to fetch changes up to cb6306d917fba789829877f9249d2bea9833e418:

  ARM: boot: dts: Add Western Digital My Book World Edition device tree (2016-04-18 11:40:21 +0200)

----------------------------------------------------------------
ARM: dts: Add OXNAS Platform Bindings

Changes since v1 pull request : http://lkml.kernel.org/r/1459521740-14050-1-git-send-email-narmstrong at baylibre.com
- rebase on 4.6 rc4

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

 Documentation/devicetree/bindings/arm/oxnas.txt                                   |   9 ++
 Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt |   2 +-
 Documentation/devicetree/bindings/vendor-prefixes.txt                             |   2 +
 arch/arm/boot/dts/Makefile                                                        |   2 +
 arch/arm/boot/dts/ox810se.dtsi                                                    | 336 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/wd-mbwe.dts                                                     | 112 ++++++++++++++++++
 6 files changed, 462 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/oxnas.txt
 create mode 100644 arch/arm/boot/dts/ox810se.dtsi
 create mode 100644 arch/arm/boot/dts/wd-mbwe.dts
