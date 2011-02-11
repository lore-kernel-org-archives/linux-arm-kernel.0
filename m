From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 11 Feb 2011 20:21:29 +0530
Subject: [PATCH v2 10/13] mfd: pruss SUART private data.
In-Reply-To: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1297435892-28278-11-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PRUSS SUART data.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 include/linux/mfd/pruss/da8xx_pru.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/pruss/da8xx_pru.h b/include/linux/mfd/pruss/da8xx_pru.h
index 50f2ede..4230d10 100644
--- a/include/linux/mfd/pruss/da8xx_pru.h
+++ b/include/linux/mfd/pruss/da8xx_pru.h
@@ -93,6 +93,11 @@ struct da8xx_pruss_can_data {
 	u32 version;
 };
 
+struct da850_evm_pruss_suart_data {
+	u32 version;
+	struct resource resource;
+};
+
 u32 pruss_get_clk_freq(struct device *dev);
 
 u32 pruss_enable(struct device *dev, u8 pruss_num);
-- 
1.7.2.3
