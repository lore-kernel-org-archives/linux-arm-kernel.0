From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Nov 2013 10:04:17 +0100
Subject: [PATCH] MAINTAINERS: drop discontinued mailing list
Message-ID: <1384160657-2953-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ST-internal Nomadik mailing list is going down. Remove
it from the MAINTAINERS file.

Cc: Olivier CLERGEAUD <olivier.clergeaud@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly for fixes unless
there are some problems with it.
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d66a03e4f57..7d280b7c1400 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1056,7 +1056,6 @@ S:	Maintained
 ARM/NOMADIK ARCHITECTURE
 M:	Alessandro Rubini <rubini@unipv.it>
 M:	Linus Walleij <linus.walleij@linaro.org>
-M:	STEricsson <STEricsson_nomadik_linux@list.st.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-nomadik/
-- 
1.8.3.1
