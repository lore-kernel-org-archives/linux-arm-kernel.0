From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  3 Nov 2016 10:11:24 +0100
Subject: [PATCH 2/2] ARM64: configs: Add Platform MHU in defconfig
In-Reply-To: <1478164284-24958-1-git-send-email-narmstrong@baylibre.com>
References: <1478164284-24958-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1478164284-24958-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0..6631bda 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -394,6 +394,7 @@ CONFIG_MSM_MMCC_8996=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_MAILBOX=y
 CONFIG_ARM_MHU=y
+CONFIG_PLATFORM_MHU=y
 CONFIG_HI6220_MBOX=y
 CONFIG_ARM_SMMU=y
 CONFIG_QCOM_SMEM=y
-- 
1.9.1
