From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  1 Nov 2012 13:26:35 +0400
Subject: [PATCH 05/15] ARM: clps711x: p720t: Unneeded inclusion of
 head-sa1100.S removed
In-Reply-To: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
References: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
Message-ID: <1351762006-27368-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/compressed/Makefile |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 537208f..5cad8a6 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -45,11 +45,6 @@ ifeq ($(CONFIG_ARCH_SHARK),y)
 OBJS		+= head-shark.o ofw-shark.o
 endif
 
-ifeq ($(CONFIG_ARCH_P720T),y)
-# Borrow this code from SA1100
-OBJS		+= head-sa1100.o
-endif
-
 ifeq ($(CONFIG_ARCH_SA1100),y)
 OBJS		+= head-sa1100.o
 endif
-- 
1.7.8.6
