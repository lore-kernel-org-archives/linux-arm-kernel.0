From: mdf@kernel.org (Moritz Fischer)
Date: Mon, 11 Sep 2017 16:22:23 -0700
Subject: [PATCH 2/2] MAINTAINERS: Add info for NI Project Sulfur DT files
In-Reply-To: <20170911232223.91894-1-mdf@kernel.org>
References: <20170911232223.91894-1-mdf@kernel.org>
Message-ID: <20170911232223.91894-2-mdf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add contact info for National Instruments Project Sulfur SDR files.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a3231bd6541d..aa54be9213bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1609,6 +1609,13 @@ ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
 S:	Maintained
 
+ARM/NATIONAL INSTRUMENTS PROJECT SULFUR SDR
+M:	Moritz Fischer <mdf@kernel.org>
+L:	usrp-users at lists.ettus.com (moderated for non-subscribers)
+W:	http://www.ettus.com
+S:	Supported
+F:	arch/arm/boot/dts/zynq-ni-sulfur*
+
 ARM/NOMADIK ARCHITECTURE
 M:	Alessandro Rubini <rubini@unipv.it>
 M:	Linus Walleij <linus.walleij@linaro.org>
-- 
2.14.1
