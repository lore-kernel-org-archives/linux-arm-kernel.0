From: florian@openwrt.org (Florian Fainelli)
Date: Sun, 15 Jul 2012 16:49:14 +0200
Subject: [PATCH 8/8] ARM: MSC814x: add MAINTAINERS entry
In-Reply-To: <1342363754-30808-1-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
Message-ID: <1342363754-30808-9-git-send-email-florian@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e30a3a..593ca15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -918,6 +918,12 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 F:	arch/arm/mach-pxa/mioa701.c
 S:	Maintained
 
+ARM/MOSCHIP MCS814X SUPPORT
+M:	Florian Fainelli <florian@openwrt.org>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+F:	arch/arm/mach-mcs814x
+S:	Maintained
+
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
 S:	Maintained
-- 
1.7.10.4
