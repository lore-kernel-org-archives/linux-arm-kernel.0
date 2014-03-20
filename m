From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 21 Mar 2014 07:30:41 +0900
Subject: [GIT PULL 2/4] Samsung 3rd DT updates for v3.15
Message-ID: <532B6C11.5070607@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ba0d7ed391b7b3fb5ca98d9cf4d067b7f5ed956b:

   ARM: dts: enable ahci sata and sata phy for exynos5250 (2014-03-18 
07:49:14 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-dt-3

for you to fetch changes up to 55ace6b285d7350d5b562ba065656c8242629a32:

   ARM: dts: Keep some essential LDOs enabled for arndale-octa board 
(2014-03-21 04:27:45 +0900)

----------------------------------------------------------------
Samsung 3rd DT updates for v3.15

- Arndale Octa board updates:
   LDO3 and LDO23 enabled for soft-reset
   LDO9 enabled for USB operation
   MDMA1 disabled to avoid imprecise external abort

Note that this is based on previous tags/samsung-dt-2

----------------------------------------------------------------
Tushar Behera (2):
       ARM: dts: Disable MDMA1 node for arndale-octa board
       ARM: dts: Keep some essential LDOs enabled for arndale-octa board

  arch/arm/boot/dts/exynos5420-arndale-octa.dts | 15 +++++++++++++++
  1 file changed, 15 insertions(+)
