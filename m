From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Sep 2012 22:07:16 -0400
Subject: [GIT PULL] dove late fixes for v3.7
Message-ID: <20120925020716.GY5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depends:
 - Based against arm-soc/for-next
 - Latest changes to arch/arm/mm/cache-tauros2.c
    c2b7e05 ARM: cache: add dt support for tauros2 cache

Misc. fixes for latest changes to mach-dove/
Fixes build breakage for mach-dove

The following changes since commit 24c7d887e4efb9d6ea26e416528efb3f1b203aae:

  Merge branch 'next/dt' into for-next (2012-09-23 21:52:54 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git dove/late-fixes

Sebastian Hesselbarth (6):
      ARM: dove: Add pcie clock support
      ARM: dove: Fix tauros2 device tree init
      ARM: dove: Fix clock names of sata and gbe
      ARM: dove: Restructure SoC device tree descriptor
      ARM: dove: Remove watchdog from DT
      ARM: dove: Add crypto engine to DT

 arch/arm/boot/dts/dove.dtsi |   49 ++++++++++++++++++++++++++++---------------
 arch/arm/mach-dove/common.c |    8 +++---
 arch/arm/mach-dove/pcie.c   |    5 ++++
 3 files changed, 41 insertions(+), 21 deletions(-)
