From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 20 Oct 2017 17:07:17 +0200
Subject: [GIT PULL] ARM: mvebu: arm64 for v4.15 (#1)
Message-ID: <87efpx6eoq.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for arm64 for mvebu for v4.15.

Gregory

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-arm64-4.15-1

for you to fetch changes up to f5bdfbe66ae7c64ef3bd64c742e34111eb0e3164:

  arm64: defconfig: enable RTC on Armada 7K/8K SoCs (2017-10-12 15:47:18 +0200)

----------------------------------------------------------------
mvebu arm64 for 4.15 (part 1)

For Armada 7K/8K, enable NAND, RTC, comphy and 10G PHY in the
defconfig

----------------------------------------------------------------
Antoine Tenart (1):
      arm64: defconfig: enable the Marvell 10G PHY as a module

Gregory CLEMENT (2):
      arm64: defconfig: enable NAND on Armada 7K/8K SoCs
      arm64: defconfig: enable RTC on Armada 7K/8K SoCs

Miquel Raynal (1):
      arm64: defconfig: enable Marvell CP110 comphy

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)
