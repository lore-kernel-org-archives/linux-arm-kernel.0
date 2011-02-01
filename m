From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue,  1 Feb 2011 20:17:45 +0530
Subject: [PATCH v1 7/9] mfd: pruss CAN private data.
In-Reply-To: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
References: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1296571667-12049-8-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PRUSS CAN data.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 include/linux/mfd/pruss/da8xx_pru.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/pruss/da8xx_pru.h b/include/linux/mfd/pruss/da8xx_pru.h
index 318dad8..2fa7ff5 100644
--- a/include/linux/mfd/pruss/da8xx_pru.h
+++ b/include/linux/mfd/pruss/da8xx_pru.h
@@ -74,6 +74,10 @@ struct da8xx_pruss_devices {
 	int (*setup)(void);
 };
 
+struct da8xx_pruss_can_data {
+	u32 version;
+};
+
 u32 pruss_get_clk_freq(struct device *dev);
 
 u32 pruss_enable(struct device *dev, u8 pruss_num);
-- 
1.7.2.3
