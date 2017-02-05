From: jnair@caviumnetworks.com (Jayachandran C)
Date: Sun, 5 Feb 2017 00:57:03 +0000
Subject: [PATCH v2 2/5] MAINTAINERS: Add Cavium ThunderX2 entry
In-Reply-To: <1486256226-43889-1-git-send-email-jnair@caviumnetworks.com>
References: <1486256226-43889-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1486256226-43889-3-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add maintainer information for Cavium ThunderX2 ARM64 processor
family.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 187b961..4f788ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2972,6 +2972,13 @@ S:	Maintained
 F:	drivers/iio/light/cm*
 F:	Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst
 
+CAVIUM THUNDERX2 ARM64 SOC
+M:	Jayachandran C <jnair@caviumnetworks.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm64/boot/dts/cavium/thunder-99xx*
+F:	Documentation/devicetree/bindings/arm/cavium-thunder2.txt
+
 CAVIUM I2C DRIVER
 M:	Jan Glauber <jglauber@cavium.com>
 M:	David Daney <david.daney@cavium.com>
-- 
2.7.4
