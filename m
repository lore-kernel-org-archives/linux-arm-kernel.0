From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 17 Oct 2012 19:25:20 +0000
Subject: [GIT PULL 1/3] ARM: Dove: fixes for v3.7
In-Reply-To: <pull-1350501943-114231>
Message-ID: <mailman.23.1350501958.1458.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/mvebu_dove_late_fixes_for_v3.7

for you to fetch changes up to a458926e16a37ef41a4fbf45957cb9faaeb6a6ef:

  ARM: dove: Add crypto engine to DT (2012-10-17 17:20:01 +0000)

----------------------------------------------------------------
Depends:
 - Based against v3.7-rc1
 - Latest changes to arch/arm/mm/cache-tauros2.c
    c2b7e05 ARM: cache: add dt support for tauros2 cache

Misc. fixes for latest changes to mach-dove/
Fixes build breakage for mach-dove

----------------------------------------------------------------
Sebastian Hesselbarth (6):
      ARM: dove: Add pcie clock support
      ARM: dove: Fix tauros2 device tree init
      ARM: dove: Fix clock names of sata and gbe
      ARM: dove: Restructure SoC device tree descriptor
      ARM: dove: Remove watchdog from DT
      ARM: dove: Add crypto engine to DT

 arch/arm/boot/dts/dove.dtsi | 49 +++++++++++++++++++++++++++++----------------
 arch/arm/mach-dove/common.c |  8 ++++----
 arch/arm/mach-dove/pcie.c   |  5 +++++
 3 files changed, 41 insertions(+), 21 deletions(-)
