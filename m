From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 27 Jul 2015 12:17:24 +0100
Subject: [PATCH v9 9/9] nvmem: Add to MAINTAINERS for nvmem framework
In-Reply-To: <1437995567-11203-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1437995567-11203-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1437995844-12004-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MAINTAINERS to nvmem framework.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cef..90e0d94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7263,6 +7263,15 @@ S:	Supported
 F:	drivers/block/nvme*
 F:	include/linux/nvme.h
 
+NVMEM FRAMEWORK
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+M:	Maxime Ripard <maxime.ripard@free-electrons.com>
+S:	Maintained
+F:	drivers/nvmem/
+F:	Documentation/devicetree/bindings/nvmem/
+F:	include/linux/nvmem-consumer.h
+F:	include/linux/nvmem-provider.h
+
 NXP-NCI NFC DRIVER
 M:	Cl?ment Perrochaud <clement.perrochaud@effinnov.com>
 R:	Charles Gorand <charles.gorand@effinnov.com>
-- 
1.9.1
