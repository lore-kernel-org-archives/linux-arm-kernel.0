From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 22 Dec 2017 11:52:03 +0100
Subject: [GIT PULL] ARM: mvebu: arm64 for v4.16 (#1)
Message-ID: <87o9mrdoh8.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for arm64 for mvebu for v4.16.

Gregory

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-arm64-4.16-1

for you to fetch changes up to ee0b915ba83212dc2288b08f1120c27c694a0d9b:

  arm64: defconfig: enable ARM_ARMADA_37XX_CPUFREQ (2017-12-21 12:11:57 +0100)

----------------------------------------------------------------
mvebu arm64 for 4.16 (part 1)

Adding the cpu frequency scaling support for Armada 37xx

----------------------------------------------------------------
Gregory CLEMENT (1):
      arm64: defconfig: enable ARM_ARMADA_37XX_CPUFREQ

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)
