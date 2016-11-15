From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 Nov 2016 10:43:55 +0800
Subject: [GIT PULL] i.MX fixes for 4.9, 2nd round
Message-ID: <20161115024353.GT3310@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4edd601c5a9c5094daa714e65063e623826f3bcc:

  ARM: imx: mach-imx6q: Fix the PHY ID mask for AR8031 (2016-10-24 21:26:01 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.9-2

for you to fetch changes up to e3c9d9d6ebfeeeee29c6240e1b5978d40d31d21f:

  ARM: dts: imx53-qsb: Fix regulator constraints (2016-11-05 16:18:16 +0800)

----------------------------------------------------------------
i.MX fixes for 4.9, 2nd round:

It fixes a boot failure on imx53-qsb board with a DA9053 PMIC, which is
caused by the regulator core change, commit fa93fd4ecc9c ("regulator:
core: Ensure we are at least in bounds for our constraints").

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx53-qsb: Fix regulator constraints

 arch/arm/boot/dts/imx53-qsb.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)
