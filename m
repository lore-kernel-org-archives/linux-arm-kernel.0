From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 May 2018 18:49:09 +0200
Subject: [GIT PULL] ARM: mvebu: arm64 for v4.18 (#1)
Message-ID: <874lj429kq.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for arm64 for mvebu for v4.18.

Gregory

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-arm64-4.18-1

for you to fetch changes up to 3eb0a48af488b5e83d2986943a1b6905ca753571:

  arm64: defconfig: enable the Armada thermal driver (2018-05-16 20:08:31 +0200)

----------------------------------------------------------------
mvebu arm64 for 4.18 (part 1)

Adding thermal for Armada 7K/8K and SPI for Armada 3700

----------------------------------------------------------------
Antoine Tenart (1):
      arm64: defconfig: enable the Armada thermal driver

Gregory CLEMENT (1):
      arm64: defconfig: enable CONFIG_SPI_ARMADA_3700

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
