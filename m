From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Wed, 2 Dec 2009 09:04:03 +0100
Subject: [PATCH] MAINTAINERS: Add arm Nomadik support
Message-ID: <20091202080403.GA27129@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alessandro Rubini <rubini@unipv.it>

Signed-off-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
---

I added plat-nomadik/ which is not yet mainstream, but will include
blocks that are common to Nomadik 8815 and newer U8500 core. There already
is a patch in Russell's queue that moves my timer code to plat-nomadik.

 MAINTAINERS |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 16129e6..7d4b5cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -771,6 +771,14 @@ ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
 S:	Maintained
 
+ARM/NOMADIK ARCHITECTURE
+M:     Alessandro Rubini <rubini@unipv.it>
+M:     STEricsson <STEricsson_nomadik_linux@list.st.com>
+L:     linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:     Maintained
+F:     arch/arm/mach-nomadik/
+F:     arch/arm/plat-nomadik/
+
 ARM/OPENMOKO NEO FREERUNNER (GTA02) MACHINE SUPPORT
 M:	Nelson Castillo <arhuaco@freaks-unidos.net>
 L:	openmoko-kernel at lists.openmoko.org (subscribers-only)
-- 
1.6.0.2
