From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 12 Mar 2012 04:09:10 -0600 (MDT)
Subject: [GIT PULL] ARM: OMAP: clock: clock patches for 3.4
Message-ID: <alpine.DEB.2.00.1203120407460.11332@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony

The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:

  Linux 3.3-rc7 (2012-03-10 13:49:52 -0800)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 clock_devel_3.4

for you to fetch changes up to ae6f0a61f6a30f387ff0ce883b4ca8ff23424b11:

  ARM: OMAP: clock: cleanup CPUfreq leftovers (2012-03-12 03:24:45 -0600)


- Paul

----------------------------------------------------------------
Ameya Palande (1):
      ARM: OMAP4: clock data: fix mult and div mask for USB_DPLL

Ilya Yanok (1):
      ARM: OMAP3: clock3xxx_data: change EMAC clocks aliases

Kevin Hilman (1):
      ARM: OMAP: clock: cleanup CPUfreq leftovers

Paul Walmsley (1):
      ARM: OMAP3: clock data: fill in some missing clockdomains

Rajendra Nayak (1):
      ARM: OMAP4: clock data: Force a DPLL clkdm/pwrdm ON before a relock

 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   80 --------------------------
 arch/arm/mach-omap2/clock.c                  |    5 --
 arch/arm/mach-omap2/clock.h                  |    8 ---
 arch/arm/mach-omap2/clock3xxx_data.c         |   10 +++-
 arch/arm/mach-omap2/clock44xx_data.c         |    5 +-
 arch/arm/plat-omap/clock.c                   |   26 --------
 arch/arm/plat-omap/include/plat/clock.h      |   10 ---
 7 files changed, 11 insertions(+), 133 deletions(-)
