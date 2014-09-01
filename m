From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 1 Sep 2014 15:10:24 +0530
Subject: [GIT PULL] DaVinci DT additions for v3.18 (merge window)
Message-ID: <54043F08.9060702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git v3.18/dt

for you to fetch changes up to 3f526696e7840239844fc7ff9b5cf014d7192c42:

  ARM: DTS: da850-evm: Enable audio via simple-card (2014-08-26 15:34:44 +0530)

----------------------------------------------------------------
DT additions for DA850. Adds EDMA and audio support.

----------------------------------------------------------------
Peter Ujfalusi (6):
      ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for mcasp0
      ARM: DTS: da850: Add node for edma0
      ARM: DTS: da850: Add node for McASP
      ARM: DTS: da850-evm: Enable McASP via DT boot
      ARM: DTS: da850-evm: Add node for tlv320aic3106 codec
      ARM: DTS: da850-evm: Enable audio via simple-card

 arch/arm/boot/dts/da850-evm.dts  |   72 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi     |   19 ++++++++++
 arch/arm/mach-davinci/da8xx-dt.c |    1 +
 3 files changed, 92 insertions(+)
