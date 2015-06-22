From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 23 Jun 2015 00:15:23 +0100
Subject: [PATCH v6 9/9] nvmem: Add to MAINTAINERS for nvmem framework
In-Reply-To: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1435014923-26711-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MAINTAINERS to nvmem framework.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2ef613..26e1829 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6993,6 +6993,15 @@ S:	Supported
 F:	drivers/block/nvme*
 F:	include/linux/nvme.h
 
+NVMEM FRAMEWORK
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+M:	Maxime Ripard <maxime.ripard@free-electrons.com>
+S:	Maintained
+F:	drivers/nvmem/
+F:	Documentation/devicetree/bindings/nvmem/
+F:	include/linux/nvmem-provider.h
+F:	include/linux/nvmem-consumer.h
+
 NXP-NCI NFC DRIVER
 M:	Cl?ment Perrochaud <clement.perrochaud@effinnov.com>
 R:	Charles Gorand <charles.gorand@effinnov.com>
-- 
1.9.1
