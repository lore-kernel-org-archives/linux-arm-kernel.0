From: davidb@codeaurora.org (David Brown)
Date: Tue, 12 Mar 2013 11:41:55 -0700
Subject: [PATCH v2 10/11] MAINTAINERS: add ssbi
In-Reply-To: <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1363113716-25897-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1363113716-25897-11-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ssbi device is specific to the Qualcomm MSM SoCs.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9561658..f8fdec5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1031,6 +1031,7 @@ F:	drivers/mmc/host/msm_sdcc.h
 F:	drivers/tty/serial/msm_serial.h
 F:	drivers/tty/serial/msm_serial.c
 F:	drivers/*/pm8???-*
+F:	drivers/ssbi/
 F:	include/linux/mfd/pm8xxx/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm.git
 S:	Maintained
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
