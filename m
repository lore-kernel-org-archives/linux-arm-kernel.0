From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 29 Apr 2014 20:03:47 +0530
Subject: [GIT PULL] DaVinci fixes for v3.15
Message-ID: <535FB84B.802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-fixes-for-v3.15-rc4

for you to fetch changes up to cf7eb979116c2568e8bc3b6a7269c7a359864ace:

  ARM: common: edma: Fix xbar mapping (2014-04-29 19:33:49 +0530)

----------------------------------------------------------------
The patch fixes EDMA crossbar mapping to actually
make it work. The patch has been tagged for stable.

----------------------------------------------------------------
Thomas Gleixner (1):
      ARM: common: edma: Fix xbar mapping

 Documentation/devicetree/bindings/dma/ti-edma.txt |    4 ++--
 arch/arm/boot/dts/am33xx.dtsi                     |    2 +-
 arch/arm/common/edma.c                            |   48 +++++++++++++++---------------------------------
 3 files changed, 18 insertions(+), 36 deletions(-)
