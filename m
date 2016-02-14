From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 16:58:52 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.5
Message-ID: <20160214085852.GT6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.5

for you to fetch changes up to f5d0ca224a071d7077bbdae347cb514949d64fd9:

  ARM: dts: imx6: remove bogus interrupt-parent from CAAM node (2016-01-28 16:48:15 +0800)

----------------------------------------------------------------
The i.MX fixes for v4.5:
 - Drop the bogus interrupt-parent from i.MX6 CAAM node, which leads to
   the CAAM IRQs not getting unmasked at the GPC level.

----------------------------------------------------------------
Lucas Stach (1):
      ARM: dts: imx6: remove bogus interrupt-parent from CAAM node

 arch/arm/boot/dts/imx6qdl.dtsi | 1 -
 1 file changed, 1 deletion(-)
