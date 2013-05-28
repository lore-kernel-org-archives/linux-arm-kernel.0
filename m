From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 14:40:35 -0400
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.11 (round 3
 cumulative)
Message-ID: <20130528184035.GD31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/defconfig-3.11-3

for you to fetch changes up to 3f4c6f43c73fc42f99f58d54e6425a06df89213f:

  arm: kirkwood: Enable cpufreq and ondemand on kirkwood_defconfig (2013-05-26 18:01:03 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.11 (round 3)

 - kirkwood
    - enable cpufreq and ondemand governor

----------------------------------------------------------------
Andrew Lunn (2):
      ARM: Kirkwood: Enable USB 3.0 in kirkwood_defconfig
      arm: kirkwood: Enable cpufreq and ondemand on kirkwood_defconfig

Ezequiel Garcia (1):
      ARM: mvebu: Add support for USB storage class in mvebu_defconfig

Jason Cooper (1):
      ARM: kirkwood: enable Sheevaplug DT in defconfig

Thomas Petazzoni (2):
      arm: mvebu: update defconfig with PCI and USB support
      arm: kirkwood: update defconfig with PCIe driver and board updates

 arch/arm/configs/kirkwood_defconfig | 10 +++++++---
 arch/arm/configs/mvebu_defconfig    |  4 ++++
 2 files changed, 11 insertions(+), 3 deletions(-)
