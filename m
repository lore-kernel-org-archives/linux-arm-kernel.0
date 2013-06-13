From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jun 2013 23:33:24 +0200
Subject: ARM: sunxi: platform changes for 3.11
Message-ID: <20130613213324.GA21940@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/sunxi-core-for-3.11

for you to fetch changes up to ec3805e6199649db2a462045a38eb1050c6151aa:

  ARM: sunxi: irqchip: Update the documentation (2013-05-29 09:39:39 +0200)

----------------------------------------------------------------
Allwinner SoCs platform additions for 3.11
  - Various cleanups and documentation updates

----------------------------------------------------------------
Maxime Ripard (3):
      ARM: sunxi: Remove init_irq declaration in machine description
      ARM: sunxi: Update datasheet documentation
      ARM: sunxi: irqchip: Update the documentation

 Documentation/arm/sunxi/README                     | 21 +++--
 .../interrupt-controller/allwinner,sun4i-ic.txt    | 87 +--------------------
 .../interrupt-controller/sunxi/sun4i-a10.txt       | 89 ++++++++++++++++++++++
 .../interrupt-controller/sunxi/sun5i-a13.txt       | 55 +++++++++++++
 arch/arm/mach-sunxi/sunxi.c                        |  2 -
 5 files changed, 159 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunxi/sun4i-a10.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sunxi/sun5i-a13.txt

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
