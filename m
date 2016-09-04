From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 04 Sep 2016 17:56:24 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.9 (#1)
Message-ID: <87lgz7zmjb.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig for mvebu for v4.9.

Gregory

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.9-1

for you to fetch changes up to 1ab9a7dae115885ddd6c24a70793c622425d6725:

  ARM: mvebu_v5_defconfig: use MV88E6XXX (2016-08-26 11:05:32 +0200)

----------------------------------------------------------------
mvebu defconfig for 4.9 (part 1)

- update dsa config with new symbol
- add flash related config for mvebu v7

----------------------------------------------------------------
Fabian Frederick (1):
      ARM: mvebu_v5_defconfig: use MV88E6XXX

Grzegorz Jaszczyk (2):
      ARM: mvebu: enable MTD command line partition table in mvebu_v7_defconfig
      ARM: mvebu: enable UBI and UBIFS in mvebu_v7_defconfig

 arch/arm/configs/mvebu_v5_defconfig | 5 +----
 arch/arm/configs/mvebu_v7_defconfig | 3 +++
 2 files changed, 4 insertions(+), 4 deletions(-)
