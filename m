From: zhongkaihua@huawei.com (Zhong Kaihua)
Date: Mon, 7 Aug 2017 17:17:14 +0800
Subject: [PATCH 3/3] arm64: defconfig: add configs for power management on
 Hi3660
In-Reply-To: <1502097434-11136-1-git-send-email-zhongkaihua@huawei.com>
References: <1502097434-11136-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <1502097434-11136-3-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kaihua Zhong <zhongkaihua@huawei.com>

Add configs for power management on Hi3660.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Ruyi Wang <wangruyi@huawei.com>
Tested-by: Kaihua Zhong <zhongkaihua@huawei.com>

---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d599a91..518d2c6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -483,6 +485,7 @@ CONFIG_ARM_MHU=y
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_HI6220_MBOX=y
+CONFIG_HI3660_MBOX=y
 CONFIG_ARM_SMMU=y
 CONFIG_ARM_SMMU_V3=y
 CONFIG_RPMSG_QCOM_SMD=y
-- 
1.8.3.2
