From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 10 Feb 2016 14:23:02 +0100
Subject: [PATCH v2 6/7] arm64: alpine: select the Alpine MSI controller driver
In-Reply-To: <1455110583-19515-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1455110583-19515-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1455110583-19515-7-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the Alpine MSI controller driver when using an Alpine platform.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index bfbefa3e0dbe..6761e12e5e13 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -2,6 +2,7 @@ menu "Platform selection"
 
 config ARCH_ALPINE
 	bool "Annapurna Labs Alpine platform"
+	select ALPINE_MSI
 	help
 	  This enables support for the Annapurna Labs Alpine
 	  Soc family.
-- 
2.7.0
