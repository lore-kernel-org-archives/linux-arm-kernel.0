From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 17 Dec 2013 22:41:11 +0100
Subject: [RFC PATCH v5 2/4] mvebu: Dove: Indicate the architecture supports
 cpufreq.
In-Reply-To: <1387316473-3250-1-git-send-email-andrew@lunn.ch>
References: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
 <1387316473-3250-1-git-send-email-andrew@lunn.ch>
Message-ID: <1387316473-3250-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARCH_HAS_CPUFREQ so allowing the cpufreq framework to be
enabled.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1f1a7eee953..908b02f8d901 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -500,6 +500,7 @@ config ARCH_IXP4XX
 
 config ARCH_DOVE
 	bool "Marvell Dove"
+	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_PJ4
 	select GENERIC_CLOCKEVENTS
-- 
1.8.5.1
