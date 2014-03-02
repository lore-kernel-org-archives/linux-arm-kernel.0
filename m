From: tony@atomide.com (Tony Lindgren)
Date: Sun, 2 Mar 2014 15:04:48 -0800
Subject: [GIT PULL] two omap dt regression fixes for v3.14-rc4
Message-ID: <20140302230448.GB5000@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4b41636878ee32d4c45a49de7749abca9721bd6a:

  ARM: OMAP3: Fix pinctrl interrupts for core2 (2014-02-27 15:35:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.14/fixes-dt-rc4

for you to fetch changes up to ae41a3030ce8901853b3cfd5e118a4b0288aa068:

  ARM: dts: omap3-gta04: Add ti,omap36xx to compatible property to avoid problems with booting (2014-03-02 09:44:45 -0800)

----------------------------------------------------------------
Two omap3430 vs 3630 device tree regression fixes for
issues booting 3430 based boards.

----------------------------------------------------------------
Javier Martinez Canillas (1):
      ARM: dts: omap3-igep: fix boot fail due wrong compatible match

Marek Belisko (1):
      ARM: dts: omap3-gta04: Add ti,omap36xx to compatible property to avoid problems with booting

 arch/arm/boot/dts/omap3-gta04.dts    | 2 +-
 arch/arm/boot/dts/omap3-igep0020.dts | 2 +-
 arch/arm/boot/dts/omap3-igep0030.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
