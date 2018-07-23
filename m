From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Mon, 23 Jul 2018 14:47:51 -0700
Subject: [PATCH v7 12/12] Add maintainers for the PECI subsystem
In-Reply-To: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
References: <20180723214751.1733-1-jae.hyun.yoo@linux.intel.com>
Message-ID: <20180723214751.1733-13-jae.hyun.yoo@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds maintainer information for the PECI subsystem.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Haiyue Wang <haiyue.wang@linux.intel.com>
Reviewed-by: James Feist <james.feist@linux.intel.com>
Reviewed-by: Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason M Biils <jason.m.bills@linux.intel.com>
---
 MAINTAINERS | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7afb9ad5a85c..28a87cb77723 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1266,6 +1266,14 @@ F:	arch/arm/mach-aspeed/
 F:	arch/arm/boot/dts/aspeed-*
 N:	aspeed
 
+ARM/ASPEED PECI DRIVER
+M:	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+M:	Jason M Biils <jason.m.bills@linux.intel.com>
+L:	linux-aspeed at lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/peci/peci-aspeed.txt
+F:	drivers/peci/peci-aspeed.c
+
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Rob Herring <robh@kernel.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
@@ -11254,6 +11262,19 @@ L:	platform-driver-x86 at vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/peaq-wmi.c
 
+PECI SUBSYSTEM
+M:	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+M:	Jason M Biils <jason.m.bills@linux.intel.com>
+L:	openbmc at lists.ozlabs.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/peci/
+F:	drivers/mfd/intel-peci-client.c
+F:	drivers/peci/
+F:	drivers/hwmon/peci-*.c
+F:	include/linux/mfd/intel-peci-client.h
+F:	include/linux/peci.h
+F:	include/uapi/linux/peci-ioctl.h
+
 PER-CPU MEMORY ALLOCATOR
 M:	Tejun Heo <tj@kernel.org>
 M:	Christoph Lameter <cl@linux.com>
-- 
2.18.0
