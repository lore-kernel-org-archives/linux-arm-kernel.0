From: kaloz@openwrt.org (Imre Kaloz)
Date: Thu,  7 Jul 2011 12:19:09 +0200
Subject: [PATCH] ARM: make CNS3XXX select CPU_V6K
Message-ID: <1310033949-25590-1-git-send-email-kaloz@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CNS3XXX is based on MPCore, so select the right CPU option for it.

Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..c2e5f3d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -321,7 +321,7 @@ config ARCH_CLPS711X
 
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
-	select CPU_V6
+	select CPU_V6K
 	select GENERIC_CLOCKEVENTS
 	select ARM_GIC
 	select MIGHT_HAVE_PCI
-- 
1.7.1
