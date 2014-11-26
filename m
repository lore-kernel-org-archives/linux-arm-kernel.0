From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 26 Nov 2014 00:19:37 -0500
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.19 (round 2)
Message-ID: <20141126051937.GV22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Folks,

Here's a round of defconfig changes.  Been in -next a few days.

Incremental pull request from tags/mvebu-defconfig-3.19 up to
tags/mvebu-defconfig-3.19-2 on the mvebu/defconfig branch.

Please pull.

thx,

Jason.


The following changes since commit 64bbc2bf639cd7891d6d9589ad665f1b30ee1b4a:

  ARM: mvebu: defconfig: Enable the mv88E6171 switch driver (2014-11-07 03:31:21 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.19-2

for you to fetch changes up to 7dd0502d69fabb35f1538aef241a7dc4b627eaba:

  ARM: mvebu: add MTD_BLOCK to mvebu_v7_defconfig (2014-11-22 02:58:53 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.19 (round 2)

 - mvebu
    - Add SDHCI, i2c, and MTD_BLOCK

----------------------------------------------------------------
Marcin Wojtas (2):
      ARM: mvebu: re-enable SDHCI driver for Armada 38x SoC in v7 defconfig
      ARM: mvebu: enable i2c device in mvebu_v7_defconfig

Thomas Petazzoni (1):
      ARM: mvebu: add MTD_BLOCK to mvebu_v7_defconfig

 arch/arm/configs/mvebu_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)
