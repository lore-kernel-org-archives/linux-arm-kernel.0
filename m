From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  3 Apr 2018 21:11:51 +0200
Subject: [PATCH v7 4/4] MAINTAINERS: add Ard as Socionext SynQuacer I2C driver
 maintainer
In-Reply-To: <20180403191151.14924-1-ard.biesheuvel@linaro.org>
References: <20180403191151.14924-1-ard.biesheuvel@linaro.org>
Message-ID: <20180403191151.14924-5-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add myself as maintainer for the newly added Socionext SynQuacer I2C
driver.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2d3f847cdc8d..6b3e60a6d282 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12816,6 +12816,12 @@ F:	include/media/soc*
 F:	drivers/media/i2c/soc_camera/
 F:	drivers/media/platform/soc_camera/
 
+SOCIONEXT SYNQUACER I2C DRIVER
+M:	Ard Biesheuvel <ard.biesheuvel@linaro.org>
+L:	linux-i2c at vger.kernel.org
+S:	Maintained
+F:	drivers/i2c/busses/i2c-synquacer.c
+
 SOCIONEXT UNIPHIER SOUND DRIVER
 M:	Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
 L:	alsa-devel at alsa-project.org (moderated for non-subscribers)
-- 
2.15.1
