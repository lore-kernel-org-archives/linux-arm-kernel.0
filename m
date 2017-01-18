From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Jan 2017 16:23:55 +0530
Subject: [GIT PULL] DaVinci fix for v4.10
Message-ID: <214ce380-3c45-423c-a7bc-e19ea1ce2a2d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 49def1853334396f948dcb4cedb9347abb318df5:

  Linux 4.10-rc4 (2017-01-15 16:21:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v4.10-part2

for you to fetch changes up to 6f042ee9cc09792c1c0f0cd8f275c2b4b29eaa96:

  ARM: dts: da850-evm: fix read access to SPI flash (2017-01-18 15:38:08 +0530)

----------------------------------------------------------------
This patch uses fast-read opcode to read the
SPI flash. This is needed for error-free read
at 30Mhz.

----------------------------------------------------------------
Fabien Parent (1):
      ARM: dts: da850-evm: fix read access to SPI flash

 arch/arm/boot/dts/da850-evm.dts | 1 +
 1 file changed, 1 insertion(+)
