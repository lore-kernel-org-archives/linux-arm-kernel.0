From: dahuang@nvidia.com (Danny Huang)
Date: Mon, 29 Oct 2012 15:21:53 +0800
Subject: [PATCH 0/2] ARM: tegra: add speedo identification for T20/T30
Message-ID: <1351495315-3282-1-git-send-email-dahuang@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds speedo identification functionality for tegra
T20 and T30. It reads speedo value from fuse and chooses CPU and core 
process ID by checking speedo corner tables.

Danny Huang (2):
  ARM: tegra: Add speedo-based process identification
  ARM: tegra: T30 speedo-based identification

 arch/arm/mach-tegra/Makefile         |   2 +
 arch/arm/mach-tegra/fuse.c           |  35 +++--
 arch/arm/mach-tegra/fuse.h           |  16 ++
 arch/arm/mach-tegra/tegra20_speedo.c | 102 ++++++++++++
 arch/arm/mach-tegra/tegra30_speedo.c | 290 +++++++++++++++++++++++++++++++++++
 5 files changed, 433 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/mach-tegra/tegra20_speedo.c
 create mode 100644 arch/arm/mach-tegra/tegra30_speedo.c

-- 
1.8.0
