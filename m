From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri, 31 Aug 2018 17:01:51 +0300
Subject: [PATCH v9 8/8] MAINTAINERS: add a maintainer for the interconnect API
In-Reply-To: <20180831140151.13972-1-georgi.djakov@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
Message-ID: <20180831140151.13972-9-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as a maintainer of the interconnect API.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..bdbab6a90c93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7578,6 +7578,16 @@ L:	linux-gpio at vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-intel-mid.c
 
+INTERCONNECT API
+M:	Georgi Djakov <georgi.djakov@linaro.org>
+S:	Maintained
+F:	Documentation/interconnect/
+F:	Documentation/devicetree/bindings/interconnect/
+F:	drivers/interconnect/
+F:	include/dt-bindings/interconnect/
+F:	include/linux/interconnect-provider.h
+F:	include/linux/interconnect.h
+
 INVENSENSE MPU-3050 GYROSCOPE DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-iio at vger.kernel.org
