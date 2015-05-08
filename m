From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri,  8 May 2015 13:07:14 +0900
Subject: [PATCH v7 4/4] MAINTAINERS: add myself as ARM/UniPhier maintainer
In-Reply-To: <1431058034-5508-1-git-send-email-yamada.masahiro@socionext.com>
References: <1431058034-5508-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1431058034-5508-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1939513..3c31a27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1525,6 +1525,13 @@ F:	drivers/rtc/rtc-ab3100.c
 F:	drivers/rtc/rtc-coh901331.c
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
 
+ARM/UNIPHIER ARCHITECTURE
+M:	Masahiro Yamada <yamada.masahiro@socionext.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/mach-uniphier/
+N:	uniphier
+
 ARM/Ux500 ARM ARCHITECTURE
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.9.1
