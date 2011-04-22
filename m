From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 22 Apr 2011 17:38:27 +0530
Subject: [PATCH v4 09/11] mfd: pruss CAN private data.
In-Reply-To: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1303474109-6212-10-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PRUSS CAN data.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 include/linux/mfd/pruss.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/pruss.h b/include/linux/mfd/pruss.h
index c5e2af2..3b46156 100644
--- a/include/linux/mfd/pruss.h
+++ b/include/linux/mfd/pruss.h
@@ -92,6 +92,11 @@ struct da850_evm_pruss_suart_data {
 	int (*setup)(void);
 };
 
+struct da850_evm_pruss_can_data {
+	u32 version;
+	int (*setup)(void);
+};
+
 s32 pruss_enable(struct device *dev, u8 pruss_num);
 
 s32 pruss_load(struct device *dev, u8 pruss_num,
-- 
1.7.2.3
