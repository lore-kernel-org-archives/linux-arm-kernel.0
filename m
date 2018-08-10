From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Fri, 10 Aug 2018 17:52:33 +0300
Subject: [PATCH v8 8/8] MAINTAINERS: add a maintainer for the interconnect API
In-Reply-To: <20180810145233.16466-1-georgi.djakov@linaro.org>
References: <20180810145233.16466-1-georgi.djakov@linaro.org>
Message-ID: <20180810145233.16466-9-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as the maintainer of the interconnect API.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32fbc6f732d4..ed1b534c901b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7420,6 +7420,16 @@ L:	linux-gpio at vger.kernel.org
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
