From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 10 Feb 2016 10:22:44 +0100
Subject: [PATCH v2 1/3] arm64: add Alpine SoC family
In-Reply-To: <1455096166-4899-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1455096166-4899-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1455096166-4899-2-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces ARCH_ALPINE to add the support of the Alpine SoC
family for the arm64 architecture.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f674bde..bfbefa3e0dbe 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -1,5 +1,11 @@
 menu "Platform selection"
 
+config ARCH_ALPINE
+	bool "Annapurna Labs Alpine platform"
+	help
+	  This enables support for the Annapurna Labs Alpine
+	  Soc family.
+
 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
 	help
-- 
2.7.0
