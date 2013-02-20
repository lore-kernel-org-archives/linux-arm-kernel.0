From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 20 Feb 2013 11:41:42 -0800
Subject: [RFC/PATCH 5/5] ARM: Kconfig: allow virt CPU accounting
In-Reply-To: <1361389302-11968-1-git-send-email-khilman@linaro.org>
References: <1361389302-11968-1-git-send-email-khilman@linaro.org>
Message-ID: <1361389302-11968-6-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the 64-bit requirement removed from virt CPU accounting,
allow ARM platforms to enable it.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9bbe760..732f8d3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -55,6 +55,7 @@ config ARM
 	select HAVE_MOD_ARCH_SPECIFIC if ARM_UNWIND
 	select MODULES_USE_ELF_REL
 	select CLONE_BACKWARDS
+	select HAVE_VIRT_CPU_ACCOUNTING
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
-- 
1.8.1.2
