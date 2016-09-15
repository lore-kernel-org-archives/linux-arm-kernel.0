From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 15 Sep 2016 20:14:22 +0530
Subject: [GIT PULL] DaVinci DTS updates for v4.9 (part 2)
Message-ID: <d231c316-a14b-1534-2bcd-29f0898b0b1c@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9d05b389846312751108b16f3f8fccd51fa92715:

  ARM: dts: da850-lcdk: Audio support via simple-card (2016-08-19 17:51:27 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.9/dts-p2

for you to fetch changes up to 9304af1b9ffa95dcb37d642852f8c67b98ea349a:

  ARM: dts: da850-lcdk: Add NAND to DT (2016-09-15 19:37:32 +0530)

----------------------------------------------------------------
This pull request adds NAND support to
DA850 based LCDK board.

----------------------------------------------------------------
Karl Beldan (1):
      ARM: dts: da850-lcdk: Add NAND to DT

 arch/arm/boot/dts/da850-lcdk.dts | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
