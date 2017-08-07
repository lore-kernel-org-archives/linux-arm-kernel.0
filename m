From: guodong.xu@linaro.org (Guodong Xu)
Date: Mon,  7 Aug 2017 22:32:00 +0800
Subject: [PATCH 5/5] arm64: defconfig: enable OP-TEE
In-Reply-To: <20170807143200.6764-1-guodong.xu@linaro.org>
References: <20170807143200.6764-1-guodong.xu@linaro.org>
Message-ID: <20170807143200.6764-6-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Chong <victor.chong@linaro.org>

This patch enables configs for Trusted Execution Environment (TEE) and
OP-TEE.

+CONFIG_TEE=y
+CONFIG_OPTEE=y

Signed-off-by: Victor Chong <victor.chong@linaro.org>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 99f7e06..81008e1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -521,6 +521,8 @@ CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
+CONFIG_TEE=y
+CONFIG_OPTEE=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_EFI_CAPSULE_LOADER=y
-- 
2.10.2
