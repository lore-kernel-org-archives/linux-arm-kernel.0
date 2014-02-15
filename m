From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 15 Feb 2014 12:05:33 +0400
Subject: [PATCH 4/4] MAINTAINERS: ARM: clps711x: Use regex patterns to involve
 all CLPS711X drivers
In-Reply-To: <1392451533-12858-1-git-send-email-shc_work@mail.ru>
References: <1392451533-12858-1-git-send-email-shc_work@mail.ru>
Message-ID: <1392451533-12858-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b00770f..bfdbe94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -816,7 +816,7 @@ ARM/CIRRUS LOGIC CLPS711X ARM ARCHITECTURE
 M:	Alexander Shiyan <shc_work@mail.ru>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Odd Fixes
-F:	arch/arm/mach-clps711x/
+N:	clps711x
 
 ARM/CIRRUS LOGIC EP93XX ARM ARCHITECTURE
 M:	Hartley Sweeten <hsweeten@visionengravers.com>
-- 
1.8.3.2
