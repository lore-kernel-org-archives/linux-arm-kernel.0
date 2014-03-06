From: mporter@linaro.org (Matt Porter)
Date: Thu, 6 Mar 2014 04:13:03 -0500
Subject: [GIT PULL] ARM: mach-bcm: cleanups for 3.15
Message-ID: <20140306091303.GG25092@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/armsoc/for-3.15/cleanup

for you to fetch changes up to 0e8b860ac6d65209beea03ee9b718089838476ef:

  ARM: bcm281xx: Rename board_init() function (2014-03-06 03:18:01 -0500)

----------------------------------------------------------------
ARM: mach-bcm: cleanups for 3.15

- make bcm281xx symbol naming consistent with SoC name
- remove unneeded and reorder bcm281xx header files
- consolidate bcm281xx reboot and l2 cache code

----------------------------------------------------------------
Alex Elder (1):
      ARM: bcm281xx: symbol cleanup

Markus Mayer (4):
      ARM: bcm281xx: Move kona_l2_cache_init() so it can be shared
      ARM: bcm281xx: Consolidate reboot code
      ARM: bcm281xx: Re-order hearder files
      ARM: bcm281xx: Rename board_init() function

 arch/arm/mach-bcm/board_bcm281xx.c | 83 +++++++++++++++++++-------------------
 arch/arm/mach-bcm/kona.c           | 64 ++++++++++-------------------
 arch/arm/mach-bcm/kona.h           |  7 +---
 3 files changed, 65 insertions(+), 89 deletions(-)
