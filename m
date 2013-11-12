From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 12 Nov 2013 14:29:45 +0100
Subject: [PATCH 3/2] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY in
 defconfig
In-Reply-To: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1384262985-2880-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARCH_SHMOBILE configuration option has been renamed to
ARCH_SHMOBILE_LEGACY. Update the defconfigs accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/configs/ape6evm_defconfig         | 2 +-
 arch/arm/configs/armadillo800eva_defconfig | 2 +-
 arch/arm/configs/bockw_defconfig           | 2 +-
 arch/arm/configs/genmai_defconfig          | 2 +-
 arch/arm/configs/koelsch_defconfig         | 2 +-
 arch/arm/configs/kzm9d_defconfig           | 2 +-
 arch/arm/configs/kzm9g_defconfig           | 2 +-
 arch/arm/configs/lager_defconfig           | 2 +-
 arch/arm/configs/mackerel_defconfig        | 2 +-
 arch/arm/configs/marzen_defconfig          | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
index 1ce3994..cb26c62 100644
--- a/arch/arm/configs/ape6evm_defconfig
+++ b/arch/arm/configs/ape6evm_defconfig
@@ -13,7 +13,7 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 # CONFIG_BLOCK is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A73A4=y
 CONFIG_MACH_APE6EVM=y
 # CONFIG_ARM_THUMB is not set
diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index fae939d..5abf1a2 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -15,7 +15,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7740=y
 CONFIG_MACH_ARMADILLO800EVA=y
 # CONFIG_SH_TIMER_TMU is not set
diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 8110d8a..80cff50 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -8,7 +8,7 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7778=y
 CONFIG_MACH_BOCKW=y
 CONFIG_MEMORY_START=0x60000000
diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index 69b1531..aa0b704 100644
--- a/arch/arm/configs/genmai_defconfig
+++ b/arch/arm/configs/genmai_defconfig
@@ -12,7 +12,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R7S72100=y
 CONFIG_MACH_GENMAI=y
 # CONFIG_SH_TIMER_CMT is not set
diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 825c16d..7fd65a0 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -9,7 +9,7 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 # CONFIG_BLOCK is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7791=y
 CONFIG_MACH_KOELSCH=y
 # CONFIG_SWP_EMULATE is not set
diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
index 6c37f4a..217f1dd 100644
--- a/arch/arm/configs/kzm9d_defconfig
+++ b/arch/arm/configs/kzm9d_defconfig
@@ -13,7 +13,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_MACH_KZM9D=y
 CONFIG_MEMORY_START=0x40000000
diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 1ad0280..9934dbc2 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -22,7 +22,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_KZM9G=y
 CONFIG_MEMORY_START=0x41000000
diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index 35bff5e..35dc8b2 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -12,7 +12,7 @@ CONFIG_SLAB=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_MACH_LAGER=y
 # CONFIG_SH_TIMER_TMU is not set
diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index 9fb1189..a61e165 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -14,7 +14,7 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_SH7372=y
 CONFIG_MACH_MACKEREL=y
 CONFIG_MEMORY_SIZE=0x10000000
diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index dd4aced..f21bd40 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -9,7 +9,7 @@ CONFIG_SYSCTL_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_SLAB=y
 # CONFIG_IOSCHED_CFQ is not set
-CONFIG_ARCH_SHMOBILE=y
+CONFIG_ARCH_SHMOBILE_LEGACY=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_MACH_MARZEN=y
 CONFIG_MEMORY_START=0x60000000
-- 
1.8.1.5
