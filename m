From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 07 Apr 2016 10:46:18 -0700
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.7 (#1)
Message-ID: <87pou1jor9.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig for mvebu for v4.7.

Gregory

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.7-1

for you to fetch changes up to e5a80a6e2f2d1b2afd6439d8f58356e93b77cb2d:

  ARM: configs: Switching to the new Marvell's cryptographic engine driver for mvebu_v5_defconfig (2016-03-30 11:51:16 +0200)

----------------------------------------------------------------
mvebu defconfig for 4.7 (part 1)

- Use the new cryto engine(mv_cesa) in the mvebu and multi-arm
  defcongig files
- Attach mvebu_*_defconfig to the mvebu maintainers

----------------------------------------------------------------
Romain Perier (3):
      ARM: configs: Enabling the new Marvell's cryptographic engine driver for mvebu_v7_defconfig
      ARM: configs: Enabling the new Marvell's cryptographic engine driver for multi_v7_defconfig
      ARM: configs: Switching to the new Marvell's cryptographic engine driver for mvebu_v5_defconfig

Thomas Petazzoni (1):
      MAINTAINERS: attach arch/arm/configs/mvebu_*_defconfig to relevant maintainers

 MAINTAINERS                         | 2 +-
 arch/arm/configs/multi_v7_defconfig | 1 +
 arch/arm/configs/mvebu_v5_defconfig | 2 +-
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)
