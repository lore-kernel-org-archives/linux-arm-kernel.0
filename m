From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 7 Mar 2013 14:08:42 +0100
Subject: [PULL PATCH 0/3] ARM: at91: Kconfig cleanup for prepare add of
 Cortex-A5 Sama5
Message-ID: <20130307130842.GA4590@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	The folowing patch serie

	move the non dt Kconfig to Kconfig.non_dt as they are plan for removal

	and update the Kconfig scheme to simplify the adding of the up comming
	Cortex-A5 SAMA5D3x series

please pull
The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git delivery/at91_3.9_dt_cleanup

for you to fetch changes up to 8ca98913f4b4e0b38d4442551d63681f4fdd0224:

  ARM: at91: renamme rm9200 dt file (2013-03-07 20:20:41 +0800)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (3):
      ARM: at91: move non DT Kconfig to Kconfig.non_dt
      ARM: at91: rename board-dt to more specific name board-dt-sam9
      ARM: at91: renamme rm9200 dt file

 arch/arm/configs/at91_dt_defconfig                          |    2 +-
 arch/arm/configs/at91sam9260_defconfig                      |    2 +-
 arch/arm/configs/at91sam9g20_defconfig                      |    2 +-
 arch/arm/configs/at91sam9g45_defconfig                      |    2 +-
 arch/arm/mach-at91/Kconfig                                  |  398 ++-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 arch/arm/mach-at91/Kconfig.non_dt                           |  399 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-at91/Makefile                                 |    4 +--
 arch/arm/mach-at91/{board-rm9200-dt.c => board-dt-rm9200.c} |    0
 arch/arm/mach-at91/{board-dt.c => board-dt-sam9.c}          |    0
 9 files changed, 407 insertions(+), 402 deletions(-)
 create mode 100644 arch/arm/mach-at91/Kconfig.non_dt
 rename arch/arm/mach-at91/{board-rm9200-dt.c => board-dt-rm9200.c} (100%)
 rename arch/arm/mach-at91/{board-dt.c => board-dt-sam9.c} (100%)

Best Regards,
J.
