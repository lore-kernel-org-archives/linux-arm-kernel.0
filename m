From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Mar 2017 18:23:16 +0100
Subject: [GIT PULL] ARM: mvebu: defconfig64 for v4.12 (#1)
Message-ID: <87lgrubncr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for defconfig64 for mvebu for v4.12.

Gregory

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig64-4.12-1

for you to fetch changes up to 66e56302842e9971426bd7e504c4db4f88cbb037:

  arm64: defconfig: enable MVPP2 (2017-03-23 17:50:13 +0100)

----------------------------------------------------------------
mvebu defconfig64 for 4.12 (part 1)

Update arm64 defconfig by adding MVPP2 for Marvell Armada 7K/8K and
MVNETA and I2C_PXA for Armada 37xx.

----------------------------------------------------------------
Gregory CLEMENT (2):
      arm64: defconfig: enable MVNETA
      arm64: defconfig: enable I2C_PXA

Thomas Petazzoni (1):
      arm64: defconfig: enable MVPP2

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)
