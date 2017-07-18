From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Jul 2017 06:59:07 +0200
Subject: [PATCH v2 5/5] ARM: qcom_defconfig: Cleanup from non-existing options
In-Reply-To: <1500353947-26122-1-git-send-email-krzk@kernel.org>
References: <1500353947-26122-1-git-send-email-krzk@kernel.org>
Message-ID: <1500353947-26122-6-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

QCOM_SMD is gone since commit 395a48053af6 ("soc: qcom: smd: Remove
standalone driver").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/qcom_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index b02039c712c3..879159e4ab58 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -199,7 +199,6 @@ CONFIG_QCOM_WCNSS_PIL=y
 CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_PM=y
 CONFIG_QCOM_SMEM=y
-CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMP2P=y
 CONFIG_QCOM_SMSM=y
-- 
2.7.4
