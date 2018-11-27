From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Tue, 27 Nov 2018 20:03:49 +0200
Subject: [PATCH v10 7/7] MAINTAINERS: add a maintainer for the interconnect API
In-Reply-To: <20181127180349.29997-1-georgi.djakov@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
Message-ID: <20181127180349.29997-8-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as the maintainer of the interconnect API.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f585d3..4f426863ff3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7694,6 +7694,16 @@ L:	linux-gpio at vger.kernel.org
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
