From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 22 May 2017 16:45:13 +0200
Subject: [PATCH v5 3/4] MAINTAINERS: add a maintainer for the Inside Secure
 crypto driver
In-Reply-To: <20170522144514.6654-1-antoine.tenart@free-electrons.com>
References: <20170522144514.6654-1-antoine.tenart@free-electrons.com>
Message-ID: <20170522144514.6654-4-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new cryptographic engine driver was added in
drivers/crypto/inside-secure. Add myself as a maintainer for this
driver.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b8f133..1f2017604f16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6602,6 +6602,12 @@ F:	Documentation/input/multi-touch-protocol.rst
 F:	drivers/input/input-mt.c
 K:	\b(ABS|SYN)_MT_
 
+INSIDE SECURE CRYPTO DRIVER
+M:	Antoine Tenart <antoine.tenart@free-electrons.com>
+F:	drivers/crypto/inside-secure/
+S:	Maintained
+L:	linux-crypto at vger.kernel.org
+
 INTEL ASoC BDW/HSW DRIVERS
 M:	Jie Yang <yang.jie@linux.intel.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-- 
2.9.4
