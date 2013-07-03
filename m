From: khilman@linaro.org (Kevin Hilman)
Date: Wed,  3 Jul 2013 11:36:41 -0700
Subject: [PATCH 3/3] ARM: Kconfig: allow virt CPU accounting
In-Reply-To: <1372876601-23881-1-git-send-email-khilman@linaro.org>
References: <1372876601-23881-1-git-send-email-khilman@linaro.org>
Message-ID: <1372876601-23881-4-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the 64-bit requirement removed from virt CPU accounting,
allow ARM platforms to enable it.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 136f263..7850612 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -61,6 +61,7 @@ config ARM
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
 	select HAVE_CONTEXT_TRACKING
+	select HAVE_VIRT_CPU_ACCOUNTING
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
-- 
1.8.3
