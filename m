From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 May 2015 23:48:41 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.1, 2nd round
Message-ID: <20150520154840.GC24844@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 68ce9a1f24b8e8894955032a4af74998315be9fe:

  ARM: dts: imx6qdl-sabreauto: remove pinctrl-assert-gpios (2015-04-28 09:05:21 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.1-2

for you to fetch changes up to e46b5a6470a5e2c8e1096f8f60887ac19949055b:

  ARM: dts: fix imx27 dtb build rule (2015-05-19 22:06:41 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.1, 2nd round:
 - Fix i.MX27 FEC register map which overlaps the SCC (Security
   Controller) register space.
 - Fix i.MX27 DTB build rule which was wrongly controlled by i.MX31
   option.

----------------------------------------------------------------
Philippe Reynes (1):
      ARM: dts: imx27: only map 4 Kbyte for fec registers

Shawn Guo (1):
      ARM: dts: fix imx27 dtb build rule

 arch/arm/boot/dts/Makefile   | 2 +-
 arch/arm/boot/dts/imx27.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
