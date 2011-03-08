From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue,  8 Mar 2011 19:27:43 +0530
Subject: [PATCH v3 4/7] mfd: pruss SUART private data.
In-Reply-To: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1299592667-21367-5-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PRUSS SUART data.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 include/linux/mfd/da8xx/da8xx_pru.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/da8xx/da8xx_pru.h b/include/linux/mfd/da8xx/da8xx_pru.h
index ba65ec0..2b9d426 100644
--- a/include/linux/mfd/da8xx/da8xx_pru.h
+++ b/include/linux/mfd/da8xx/da8xx_pru.h
@@ -94,6 +94,10 @@ struct da8xx_pruss_devices {
 	struct resource *resources;
 };
 
+struct da850_evm_pruss_suart_data {
+	u32 version;
+};
+
 u32 pruss_get_clk_freq(struct device *dev);
 
 s32 pruss_enable(struct device *dev, u8 pruss_num);
-- 
1.7.2.3
