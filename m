From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 10 Oct 2012 19:45:30 +0400
Subject: [PATCH 4/7] ARM: clps711x: added missing definitions
In-Reply-To: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
References: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
Message-ID: <1349883933-8881-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/include/mach/clps711x.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-clps711x/include/mach/clps711x.h b/arch/arm/mach-clps711x/include/mach/clps711x.h
index c82e21c..aee352c 100644
--- a/arch/arm/mach-clps711x/include/mach/clps711x.h
+++ b/arch/arm/mach-clps711x/include/mach/clps711x.h
@@ -257,6 +257,9 @@
 #define MEMCFG_BUS_WIDTH_16	(0)
 #define MEMCFG_BUS_WIDTH_8	(3)
 
+#define MEMCFG_SQAEN		(1 << 6)
+#define MEMCFG_CLKENB		(1 << 7)
+
 #define MEMCFG_WAITSTATE_8_3	(0 << 2)
 #define MEMCFG_WAITSTATE_7_3	(1 << 2)
 #define MEMCFG_WAITSTATE_6_3	(2 << 2)
-- 
1.7.8.6
