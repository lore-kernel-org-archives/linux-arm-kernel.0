From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 19 Dec 2011 11:01:56 -0700
Subject: [PATCH 0/2] arm/tegra: Fix section mismatch errors in pinmux
Message-ID: <1324317718-24464-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches in Tegra's for-3.3/soc branch introduce some section mismatch
errors when building with CONFIG_DEBUG_SECTION_MISMATCH=y. This series
fixes them. I patched each file separately in case you want to squash
these into the original patches.

tegra20: 6996e08 arm/tegra: prepare pinmux code for multiple tegra variants
tegra30: 241682c arm/tegra: pinmux tables and definitions for tegra30

Stephen Warren (2):
  arm/tegra: Fix section mismatch errors in tegra20 pinmux
  arm/tegra: Fix section mismatch errors in tegra30 pinmux

 arch/arm/mach-tegra/pinmux-tegra20-tables.c |    2 +-
 arch/arm/mach-tegra/pinmux-tegra30-tables.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
