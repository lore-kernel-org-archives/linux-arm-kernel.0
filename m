From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 10 Apr 2012 17:06:40 +0200
Subject: [PATCH v6 17/17] pwm: Take over maintainership of the PWM subsystem
In-Reply-To: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
References: <1334070400-25013-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <1334070400-25013-18-git-send-email-thierry.reding@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm taking over the maintainership of the PWM subsystem. This commit
also adds the URLs to the gitorious project and repository as well as
any missing files related to the PWM subsystem.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Note: I guess this patch in particular could use some Acked-by, maybe from
Arnd and Sascha so that people will know this happens with their blessing.

 MAINTAINERS |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 275db57..55a11ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5420,10 +5420,16 @@ S:	Maintained
 F:	Documentation/video4linux/README.pvrusb2
 F:	drivers/media/video/pvrusb2/
 
-PWM core
-M:	Sascha Hauer <s.hauer@pengutronix.de>
+PWM SUBSYSTEM
+M:	Thierry Reding <thierry.reding@avionic-design.de>
 L:	linux-kernel at vger.kernel.org
 S:	Maintained
+W:	http://gitorious.org/linux-pwm
+T:	git git://gitorious.org/linux-pwm/linux-pwm.git
+F:	Documentation/pwm.txt
+F:	Documentation/devicetree/bindings/pwm/
+F:	include/linux/pwm.h
+F:	include/linux/of_pwm.h
 F:	drivers/pwm/
 
 PXA2xx/PXA3xx SUPPORT
-- 
1.7.9.6
