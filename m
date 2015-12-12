From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 12 Dec 2015 13:14:01 +0530
Subject: [RESEND PATCH v5 7/8] MAINTAINERS: add maintainers entry for
 drivers/soc/samsung
In-Reply-To: <1449906242-20843-1-git-send-email-pankaj.dubey@samsung.com>
References: <1449906242-20843-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1449906242-20843-8-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds maintainers entry for new driver folder
drivers/soc/samsung

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Kukjin Kim <kgene@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e9caa4b..2c4b21f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1465,6 +1465,7 @@ F:	arch/arm/mach-s5p*/
 F:	arch/arm/mach-exynos*/
 F:	drivers/*/*s3c2410*
 F:	drivers/*/*/*s3c2410*
+F:	drivers/soc/samsung/*
 F:	drivers/spi/spi-s3c*
 F:	sound/soc/samsung/*
 F:	Documentation/arm/Samsung/
-- 
1.9.1
