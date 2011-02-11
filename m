From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 11 Feb 2011 20:21:23 +0530
Subject: [PATCH v2 04/13] mfd: pruss CAN private data.
In-Reply-To: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1297435892-28278-5-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PRUSS CAN data.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 include/linux/mfd/pruss/da8xx_pru.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/pruss/da8xx_pru.h b/include/linux/mfd/pruss/da8xx_pru.h
index 68d8421..50f2ede 100644
--- a/include/linux/mfd/pruss/da8xx_pru.h
+++ b/include/linux/mfd/pruss/da8xx_pru.h
@@ -89,6 +89,10 @@ struct da8xx_pruss_devices {
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
