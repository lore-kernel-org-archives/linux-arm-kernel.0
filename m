From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Jan 2015 11:28:19 +0100
Subject: [PATCH] pinctrl: MAINTAINERS: add git tree reference
Message-ID: <1421663299-7391-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference my pinctrl GIT tree @kernel.org

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3589d67437f8..cdc238c3d8cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7400,6 +7400,7 @@ F:	drivers/crypto/picoxcell*
 PIN CONTROL SUBSYSTEM
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-gpio at vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
 S:	Maintained
 F:	drivers/pinctrl/
 F:	include/linux/pinctrl/
-- 
1.9.3
