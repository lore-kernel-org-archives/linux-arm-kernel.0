From: timur@codeaurora.org (Timur Tabi)
Date: Wed,  3 May 2017 11:18:00 -0500
Subject: [PATCH 9/9] arm64: defconfig: enable the Qualcomm Technologies EMAC
 Ethernet driver
In-Reply-To: <1493828280-6620-1-git-send-email-timur@codeaurora.org>
References: <1493828280-6620-1-git-send-email-timur@codeaurora.org>
Message-ID: <1493828280-6620-10-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The EMAC is present on Qualcomm Technologies' server and some mobile
chips, and is used as the primary Ethernet interface.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 424064b..9f574c3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -191,6 +191,7 @@ CONFIG_IGBVF=y
 CONFIG_MVNETA=y
 CONFIG_MVPP2=y
 CONFIG_SKY2=y
+CONFIG_QCOM_EMAC=m
 CONFIG_RAVB=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
