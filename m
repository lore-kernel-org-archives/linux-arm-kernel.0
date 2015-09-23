From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 23 Sep 2015 08:39:42 +0200
Subject: [PATCH v2 0/2] Make Tegra cpuidle driver PSCI compatible
Message-ID: <cover.1442990383.git.jan.kiszka@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seems those two fell under the table. So I'm resending, rebased over
current 4.3-rc2, resolving a conflict of patch 1.

Jan

Jan Kiszka (2):
  ARM: Availability of psci_smp_available depends on CONFIG_SMP
  ARM: tegra: Disable cpuidle driver if PSCI is present

 arch/arm/include/asm/psci.h | 2 +-
 arch/arm/mach-tegra/Kconfig | 1 +
 arch/arm/mach-tegra/tegra.c | 4 +++-
 3 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.1.4
