From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 26 Feb 2016 15:30:13 +0100
Subject: [GIT PULL] ARM: mvebu: arm64 for v4.6 (#2)
Message-ID: <87a8mno87e.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for arm64 for mvebu for v4.6.

Gregory

The following changes since commit e772ca05cceb1480bdc7a7579e042b18558d0959:

  arm64: defconfig: enable Armada 3700 related config (2016-02-17 16:23:20 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-arm64-4.6-2

for you to fetch changes up to b3920b2b2388117d0fae5e2d15d626050f6883ea:

  arm64: update ARCH_MVEBU for Marvell Armada 7K/8K support (2016-02-19 14:08:10 +0100)

----------------------------------------------------------------
mvebu arm64 for 4.6 (part 2)

Add initial support for Armada 7K/8K
Update Marvell documentation

----------------------------------------------------------------
Arnd Bergmann (1):
      Documentation: arm: update Marvell product listing

Thomas Petazzoni (4):
      Documentation: arm: improve Armada 37xx description
      Documentation: arm: add link to Armada 38x Functional Spec
      Documentation: arm: add Marvell Armada 7K and 8K families
      arm64: update ARCH_MVEBU for Marvell Armada 7K/8K support

 Documentation/arm/Marvell/README | 158 +++++++++++++++++++++++++++++++--------
 arch/arm64/Kconfig.platforms     |  11 ++-
 2 files changed, 136 insertions(+), 33 deletions(-)
