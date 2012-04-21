From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Apr 2012 13:11:18 +0400
Subject: [PATCH 05/17] ARM clps711x: Added missing definitions for PORT C
In-Reply-To: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
Message-ID: <1334999490-27177-6-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/include/asm/hardware/clps7111.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/hardware/clps7111.h b/arch/arm/include/asm/hardware/clps7111.h
index 4447722..84358d8 100644
--- a/arch/arm/include/asm/hardware/clps7111.h
+++ b/arch/arm/include/asm/hardware/clps7111.h
@@ -36,9 +36,11 @@
 
 #define PADR		(0x0000)
 #define PBDR		(0x0001)
+#define PCDR		(0x0002)
 #define PDDR		(0x0003)
 #define PADDR		(0x0040)
 #define PBDDR		(0x0041)
+#define PCDDR		(0x0042)
 #define PDDDR		(0x0043)
 #define PEDR		(0x0080)
 #define PEDDR		(0x00c0)
-- 
1.7.3.4
