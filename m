From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Feb 2016 16:30:14 +0000
Subject: [PATCH] arm64: kconfig: add submenu for 8.2 architectural features
Message-ID: <1456504214-30812-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UAO is a feature of ARMv8.2, so add a submenu like we have for 8.1.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b6460911dd92..cfed7057d4ce 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -758,6 +758,8 @@ config ARM64_LSE_ATOMICS
 
 endmenu
 
+menu "ARMv8.2 architectural features"
+
 config ARM64_UAO
 	bool "Enable support for User Access Override (UAO)"
 	default y
@@ -779,6 +781,8 @@ config ARM64_UAO
 	  regular load/store instructions if the cpu does not implement the
 	  feature.
 
+endmenu
+
 config ARM64_MODULE_CMODEL_LARGE
 	bool
 
-- 
2.1.4
