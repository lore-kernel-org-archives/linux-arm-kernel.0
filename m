From: olof@lixom.net (Olof Johansson)
Date: Fri, 9 Dec 2016 10:01:47 -0800
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20161209180147.GA29286@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This should be our last set of fixes for 4.9. Please merge!


Thanks,

-Olof

The following changes since commit 909e481e2467f202b97d42beef246e8829416a85:

  arm64: dts: juno: fix cluster sleep state entry latency on all SoC versions (2016-12-02 17:28:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 038ccb3e8cee52e07dc118ff99f47eaebc1d0746:

  ARM: dts: orion5x: fix number of sata port for linkstation ls-gl (2016-12-08 10:19:24 -0800)

----------------------------------------------------------------
ARM: Final batch of SoC fixes

A few fixes that have trickled in over the last week, all fixing minor
errors in devicetrees -- UART pin assignment on Allwinner H3, correcting
number of SATA ports on a Marvell-based Linkstation platform and a display
clock fix for Freescale/NXP i.MX7D that fixes a freeze when starting up X.

----------------------------------------------------------------
Jorik Jonker (1):
      dts: sun8i-h3: correct UART3 pin definitions

Roger Shimizu (1):
      ARM: dts: orion5x: fix number of sata port for linkstation ls-gl

Stefan Agner (1):
      ARM: dts: imx7d: fix LCDIF clock assignment

 arch/arm/boot/dts/imx7s.dtsi                   | 5 ++---
 arch/arm/boot/dts/orion5x-linkstation-lsgl.dts | 4 ++++
 arch/arm/boot/dts/sun8i-h3.dtsi                | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)
