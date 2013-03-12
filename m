From: davidb@codeaurora.org (David Brown)
Date: Tue, 12 Mar 2013 11:41:47 -0700
Subject: [PATCH v2 02/11] fix: Use EXPORT_SYMBOL_GPL
In-Reply-To: <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1363113716-25897-3-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/ssbi/ssbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ssbi/ssbi.c b/drivers/ssbi/ssbi.c
index 8b0b10d..c08a7b8 100644
--- a/drivers/ssbi/ssbi.c
+++ b/drivers/ssbi/ssbi.c
@@ -242,7 +242,7 @@ int msm_ssbi_read(struct device *dev, u16 addr, u8 *buf, int len)
 
 	return ret;
 }
-EXPORT_SYMBOL(msm_ssbi_read);
+EXPORT_SYMBOL_GPL(msm_ssbi_read);
 
 int msm_ssbi_write(struct device *dev, u16 addr, u8 *buf, int len)
 {
@@ -259,7 +259,7 @@ int msm_ssbi_write(struct device *dev, u16 addr, u8 *buf, int len)
 
 	return ret;
 }
-EXPORT_SYMBOL(msm_ssbi_write);
+EXPORT_SYMBOL_GPL(msm_ssbi_write);
 
 static int msm_ssbi_add_slave(struct msm_ssbi *ssbi,
 				const struct msm_ssbi_slave_info *slave)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
