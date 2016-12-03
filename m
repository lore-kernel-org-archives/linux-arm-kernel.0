From: stefan@datenfreihafen.org (Stefan Schmidt)
Date: Sat,  3 Dec 2016 22:59:57 +0100
Subject: [PATCH] arm: MAINTAINERS: transfer maintainership for the EZX platform
Message-ID: <1480802397-25575-1-git-send-email-stefan@datenfreihafen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neither Daniel, Harald or myself are looking into this anymore.
Robert thankfully agreed to handle the maintenance from now on.
Also remove the outdated entries for website, git tree and
mailing list.

Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
---
 MAINTAINERS | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2dd40c5..661af76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1203,13 +1203,9 @@ S:	Maintained
 N:	efm32
 
 ARM/EZX SMARTPHONES (A780, A910, A1200, E680, ROKR E2 and ROKR E6)
-M:	Daniel Ribeiro <drwyrm@gmail.com>
-M:	Stefan Schmidt <stefan@openezx.org>
-M:	Harald Welte <laforge@openezx.org>
-L:	openezx-devel at lists.openezx.org (moderated for non-subscribers)
-W:	http://www.openezx.org/
+M:	Robert Jarzmik <robert.jarzmik@free.fr>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	topgit git://git.openezx.org/openezx.git
 F:	arch/arm/mach-pxa/ezx.c
 
 ARM/FARADAY FA526 PORT
-- 
2.5.5
