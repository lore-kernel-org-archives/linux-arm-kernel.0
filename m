From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 18 Jul 2014 18:13:51 -0400
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.17 (round 2)
Message-ID: <20140718221351.GN24496@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

Here's all the defconfig changes we have for mvebu this time around.
The big one is the removal of kirkwood_defconfig, cooresponding to the
mach-kirkwood/ removal in mvebu/soc.

This is an incremental pull request from tags/mvebu-defconfig-3.17 up to
tags/mvebu-defconfig-3.17-2 on the mvebu/defconfig branch.

Please pull.

thx,

Jason.

The following changes since commit 5658d58545388850c77a070fb3b882ddd958eb88:

  ARM: multi_v5: Enable LaCie 2Big and 5Big Network v2 (2014-06-20 20:50:23 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.17-2

for you to fetch changes up to c1eed8d2ff67b18f3892016f40ad6899ac6cf477:

  ARM: mvebu: update mvebu_v7_defconfig with cpufreq support (2014-07-16 12:51:39 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.17 (round 2)

 - mvebu
   - Add appended_dtb support
   - Add devtmpfs support
   - Add 375 network driver
   - Add cpuidle support
   - Add cpufreq support

 - kirkwood
   - Remove kirkwood_defconfig

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: Remove kirkwood_defconfig

Gregory CLEMENT (1):
      ARM: mvebu: defconfig: enable cpuidle support in mvebu_v7_defconfig

Marcin Wojtas (1):
      ARM: mvebu: enable Armada 375 network driver in mvebu_v7_defconfig

Thomas Petazzoni (3):
      ARM: mvebu: add appended DTB support in mvebu_v5_defconfig
      ARM: mvebu: add devtmpfs to mvebu_v5_defconfig
      ARM: mvebu: update mvebu_v7_defconfig with cpufreq support

 arch/arm/configs/kirkwood_defconfig | 181 ------------------------------------
 arch/arm/configs/mvebu_v5_defconfig |   4 +
 arch/arm/configs/mvebu_v7_defconfig |   5 +
 3 files changed, 9 insertions(+), 181 deletions(-)
 delete mode 100644 arch/arm/configs/kirkwood_defconfig
