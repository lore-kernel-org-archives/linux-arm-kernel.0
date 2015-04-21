From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 21 Apr 2015 16:21:30 +0900
Subject: [PATCH v4 4/4] MAINTAINERS: add myself as ARM/UniPhier maintainer
In-Reply-To: <1429600890-26713-1-git-send-email-yamada.masahiro@socionext.com>
References: <1429600890-26713-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1429600890-26713-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce3eb0f..26b42be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1533,6 +1533,13 @@ F:	drivers/rtc/rtc-ab3100.c
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
