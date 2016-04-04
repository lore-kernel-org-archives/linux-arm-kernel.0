From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:44 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.7
Message-ID: <cover.1459732004.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.7.


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.7

for you to fetch changes up to 352486b164ad41f2536f77d568ada7d729d080c2:

  ARM: shmobile: defconfig: enable I2C demultiplexer and slave eeprom (2016-03-28 10:05:01 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.7

* Enable I2C demultiplexer and slave eeprom in
  shmobile and multi_v7defconfigs

----------------------------------------------------------------
Wolfram Sang (2):
      ARM: multi_v7_defconfig: enable I2C demultiplexer and slave eeprom
      ARM: shmobile: defconfig: enable I2C demultiplexer and slave eeprom

 arch/arm/configs/multi_v7_defconfig | 2 ++
 arch/arm/configs/shmobile_defconfig | 3 +++
 2 files changed, 5 insertions(+)
