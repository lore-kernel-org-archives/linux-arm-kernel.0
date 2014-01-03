From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri,  3 Jan 2014 16:48:46 +0100
Subject: [PATCH 2/4] ARM: shmobile: Set CONFIG_LOCALVERSION in defconfigs
In-Reply-To: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
References: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1388764128-27686-2-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

This allows to derive the kernel flavor from the kernel version.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/configs/ape6evm_defconfig         |    1 +
 arch/arm/configs/armadillo800eva_defconfig |    1 +
 arch/arm/configs/bockw_defconfig           |    1 +
 arch/arm/configs/genmai_defconfig          |    1 +
 arch/arm/configs/koelsch_defconfig         |    1 +
 arch/arm/configs/kzm9d_defconfig           |    1 +
 arch/arm/configs/kzm9g_defconfig           |    1 +
 arch/arm/configs/lager_defconfig           |    1 +
 arch/arm/configs/mackerel_defconfig        |    1 +
 arch/arm/configs/marzen_defconfig          |    1 +
 10 files changed, 10 insertions(+)

diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
index c13f560f07db..554611c82d04 100644
--- a/arch/arm/configs/ape6evm_defconfig
+++ b/arch/arm/configs/ape6evm_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-ape6evm"
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 1edc2ce32063..2e8212d4c51e 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-armadillo800eva"
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 564eab338f02..0f583fecfc69 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-bockw"
 # CONFIG_ARM_PATCH_PHYS_VIRT is not set
 CONFIG_KERNEL_LZMA=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index 5fa44cb6e915..ede35f400df2 100644
--- a/arch/arm/configs/genmai_defconfig
+++ b/arch/arm/configs/genmai_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-genmai"
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_IKCONFIG=y
diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index c8ebeb1f0497..f795ea42a8fc 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-koelsch"
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_IKCONFIG=y
diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
index 3ee3858939d9..2d1b9b3740dd 100644
--- a/arch/arm/configs/kzm9d_defconfig
+++ b/arch/arm/configs/kzm9d_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-kzm9d"
 # CONFIG_ARM_PATCH_PHYS_VIRT is not set
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index 800faff9df1d..26a3303bcdf7 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-kzm9g"
 # CONFIG_ARM_PATCH_PHYS_VIRT is not set
 CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
index da8fa5e8719b..18b9dd96250a 100644
--- a/arch/arm/configs/lager_defconfig
+++ b/arch/arm/configs/lager_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-lager"
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_IKCONFIG=y
diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
index 9d406022d72b..f303b8c5b7d2 100644
--- a/arch/arm/configs/mackerel_defconfig
+++ b/arch/arm/configs/mackerel_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-mackerel"
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index fe3d8f7c0a2c..b89105b12ae6 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -1,3 +1,4 @@
+CONFIG_LOCALVERSION="-marzen"
 # CONFIG_ARM_PATCH_PHYS_VIRT is not set
 CONFIG_EXPERIMENTAL=y
 CONFIG_KERNEL_LZMA=y
-- 
1.7.9.5
