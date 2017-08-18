From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Aug 2017 09:55:48 +0800
Subject: [GIT PULL] i.MX fixes for 4.13, round 3
Message-ID: <20170818015546.GJ7608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8317562097acec4c9e9750eb91115687931bca35:

  ARM: dts: i.MX25: add ranges to tscadc (2017-08-05 13:22:32 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.13-3

for you to fetch changes up to c40bc54fdf2d52a80f66b365f1eac9d43b32e107:

  ARM: dts: imx6qdl-nitrogen6_som2: fix PCIe reset (2017-08-18 09:40:40 +0800)

----------------------------------------------------------------
i.MX fixes for 4.13, round 3:
 - Fix PCIe reset GPIO of imx6qdl-nitrogen6_som2 board, which was
   a bad copy from nitrogen6_max device tree.

----------------------------------------------------------------
Gary Bisson (1):
      ARM: dts: imx6qdl-nitrogen6_som2: fix PCIe reset

 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
