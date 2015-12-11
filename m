From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 11 Dec 2015 15:21:42 +0100
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.5 (#2)
Message-ID: <87io456p6x.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for defconfig for mvebu for v4.5.

Gregory

The following changes since commit a0638365f6850855728a5ef5caf2aeab82a58035:

  ARM: mvebu: add Kirkwood cpuidle to defconfig (2015-11-30 15:26:45 +0100)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.5-2

for you to fetch changes up to ab8d80eb5dfd7f4f57364392d746a7700a891e68:

  ARM: mvebu: update v5 defconfig for Orion5x machines (2015-12-08 10:55:20 +0100)

----------------------------------------------------------------
mvebu defconfig for 4.5 (part 2)

- Reenable DSA in mvebu_v5_defconfig
- Update multi_v5_defconfig after adding Orion5x to multiarch

----------------------------------------------------------------
Andrew Lunn (5):
      ARM: config: Regenerate multi_v5_defconfig
      ARM: config: Reenable DSA in multi_v5_defconfig
      ARM: config: Add orion5x to multi_v5_defconfig
      ARM: mvebu: Reenable DSA in mvebu_v5_defconfig
      ARM: mvebu: update v5 defconfig for Orion5x machines

 arch/arm/configs/multi_v5_defconfig | 43 +++++++++++++++++++++++++++----------
 arch/arm/configs/mvebu_v5_defconfig | 31 +++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 12 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
