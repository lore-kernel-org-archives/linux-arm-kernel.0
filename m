From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 17 Mar 2013 20:15:41 +0000
Subject: [GIT PULL 1/3] ARM: mvebu: cleanup for v3.10
In-Reply-To: <1363551341.dDc8Eea0.32562@triton>
Message-ID: <1363551341.b0ae2871.32562@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/cleanup_for_v3.10

for you to fetch changes up to 3e762c86b337f6990cdbd71890921b4dd9351ed9:

  arm: mach-orion5x: use mv_mbus_dram_info() in PCI code

----------------------------------------------------------------
mvebu cleanup for v3.10
    
     - plat-orion: prep for mvebu-mbus driver
----------------------------------------------------------------
Thomas Petazzoni (3):
      arm: plat-orion: only build addr-map.c when needed
      arm: plat-orion: use mv_mbus_dram_info() in PCIe code
      arm: mach-orion5x: use mv_mbus_dram_info() in PCI code

 arch/arm/mach-orion5x/pci.c  |  7 ++++---
 arch/arm/plat-orion/Makefile |  6 +++++-
 arch/arm/plat-orion/pcie.c   | 10 ++++++----
 3 files changed, 15 insertions(+), 8 deletions(-)
