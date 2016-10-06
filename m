From: isubramanian@apm.com (Iyappan Subramanian)
Date: Thu,  6 Oct 2016 14:35:58 -0700
Subject: [PATCH net-next 2/2] arm64: xgene: defconfig: Enable Standby GPIO
In-Reply-To: <1475789758-5196-1-git-send-email-isubramanian@apm.com>
References: <1475789758-5196-1-git-send-email-isubramanian@apm.com>
Message-ID: <1475789758-5196-3-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_GPIO_XGENE_SB.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Quan Nguyen <qnguyen@apm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eadf485..be52a00 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -240,6 +240,7 @@ CONFIG_GPIO_DWAPB=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
+CONFIG_GPIO_XGENE_SB=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_MAX77620=y
-- 
1.9.1
