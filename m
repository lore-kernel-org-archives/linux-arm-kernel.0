From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 10 May 2010 22:07:01 +0200
Subject: [PATCH 4/4] MAINTAINERS: update for ARM/Gemini
In-Reply-To: <1273522021-14436-1-git-send-email-ulli.kroll@googlemail.com>
References: <1273522021-14436-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <1273522021-14436-5-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
---
 MAINTAINERS |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 449d444..8a0fe7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -620,10 +620,10 @@ M:	Richard Purdie <rpurdie@rpsys.net>
 S:	Maintained
 
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
-M:	Paulius Zaleckas <paulius.zaleckas@gmail.com>
+M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-T:	git git://gitorious.org/linux-gemini/mainline.git
-S:	Odd Fixes
+T:	git git://git.berlios.de/gemini-board
+S:	Maintained
 F:	arch/arm/mach-gemini/
 
 ARM/EBSA110 MACHINE SUPPORT
@@ -645,9 +645,10 @@ T:	topgit git://git.openezx.org/openezx.git
 F:	arch/arm/mach-pxa/ezx.c
 
 ARM/FARADAY FA526 PORT
-M:	Paulius Zaleckas <paulius.zaleckas@gmail.com>
+M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Odd Fixes
+S:	Maintained
+T:	git://git.berlios.de/gemini-board
 F:	arch/arm/mm/*-fa*
 
 ARM/FOOTBRIDGE ARCHITECTURE
-- 
1.7.0.3
