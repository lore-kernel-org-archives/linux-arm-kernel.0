From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 9 Nov 2014 01:55:38 -0500
Subject: [GIT PULL] ARM: mvebu: defconfig changes for v3.19
Message-ID: <20141109065538.GX3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's a small round of changes I've collected so far.  Nothing real
exciting.  They've been in -next at least 4 cycles.

Please pull.

thx,

Jason.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-3.19

for you to fetch changes up to 64bbc2bf639cd7891d6d9589ad665f1b30ee1b4a:

  ARM: mvebu: defconfig: Enable the mv88E6171 switch driver (2014-11-07 03:31:21 +0000)

----------------------------------------------------------------
mvebu defconfig changes for v3.19

 - Add options for DLink DIR665
 - Add Armada 370 simple-card audio option
 - Add mv88E6171 switch driver option

----------------------------------------------------------------
Andrew Lunn (3):
      ARM: mvebu: Add DLINK DIR665 options to mvebu_v5_defconfig
      ARM: config: Add DLINK DIR665 options to multi_v5_defconfig
      ARM: mvebu: defconfig: Enable the mv88E6171 switch driver

Thomas Petazzoni (1):
      ARM: mvebu: update mvebu_v7_defconfig for Armada 370 audio

 arch/arm/configs/multi_v5_defconfig | 2 ++
 arch/arm/configs/mvebu_v5_defconfig | 2 ++
 arch/arm/configs/mvebu_v7_defconfig | 6 +++++-
 3 files changed, 9 insertions(+), 1 deletion(-)
