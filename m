From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Nov 2012 13:46:22 -0800
Subject: [GIT PULL] few omap regression fixes for v3.7-rc5
Message-ID: <20121121214622.GH18567@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc5/fixes-signed

for you to fetch changes up to 1ef43369c681bf30a980a4ba42df20514b15fdda:

  ARM: OMAP4: TWL: mux sys_drm_msecure as output for PMIC (2012-11-12 14:11:47 -0800)

----------------------------------------------------------------
Few more regression fixes related to u-boot only muxing
essential pins.

----------------------------------------------------------------
Anders Hedlund (1):
      ARM: OMAP3: igep0020: Set WIFI/BT GPIO pins in correct mux mode

Javier Martinez Canillas (1):
      ARM: OMAP: Add maintainer entry for IGEP machines

Kevin Hilman (1):
      ARM: OMAP4: TWL: mux sys_drm_msecure as output for PMIC

 MAINTAINERS                          | 8 ++++++++
 arch/arm/mach-omap2/board-igep0020.c | 5 +++++
 arch/arm/mach-omap2/twl-common.c     | 1 +
 3 files changed, 14 insertions(+)
