From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 20 Mar 2013 16:34:27 -0700
Subject: [PATCH 3/3] ARM: Kconfig: allow virt CPU accounting
In-Reply-To: <1363822467-6275-1-git-send-email-khilman@linaro.org>
References: <1363822467-6275-1-git-send-email-khilman@linaro.org>
Message-ID: <1363822467-6275-4-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the 64-bit requirement removed from virt CPU accounting,
allow ARM platforms to enable it.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..9473d55 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -59,6 +59,7 @@ config ARM
 	select CLONE_BACKWARDS
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select HAVE_VIRT_CPU_ACCOUNTING
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
-- 
1.8.2
