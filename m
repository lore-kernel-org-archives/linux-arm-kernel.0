From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 12 Mar 2014 13:32:58 +0900
Subject: [PATCH v2 1/4] clk: samsung: add new Kconfig for Samsung common clock
 options
In-Reply-To: <1394598781-3848-1-git-send-email-pankaj.dubey@samsung.com>
References: <1394598781-3848-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1394598781-3848-2-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new Kconfig file for adding new config option
as COMMON_CLK_SAMSUNG for Samsung common clock. This patch also
moves S3C24XX specific clock options here in this file.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/clk/samsung/Kconfig |   11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 drivers/clk/samsung/Kconfig

diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
new file mode 100644
index 0000000..26eb446
--- /dev/null
+++ b/drivers/clk/samsung/Kconfig
@@ -0,0 +1,11 @@
+config COMMON_CLK_SAMSUNG
+	bool
+	select COMMON_CLK
+
+config S3C2412_COMMON_CLK
+	bool
+	select COMMON_CLK_SAMSUNG
+
+config S3C2443_COMMON_CLK
+	bool
+	select COMMON_CLK_SAMSUNG
-- 
1.7.9.5
