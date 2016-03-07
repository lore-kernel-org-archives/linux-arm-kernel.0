From: chanho.min@lge.com (Chanho Min)
Date: Mon, 7 Mar 2016 13:09:58 +0900
Subject: [PATCH 2/4] arm64: defconfig: enable ARCH_LG1K
In-Reply-To: <1457323800-26904-1-git-send-email-chanho.min@lge.com>
References: <1457323800-26904-1-git-send-email-chanho.min@lge.com>
Message-ID: <1457323800-26904-3-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building LG1K support in the defconfig.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm64/configs/defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 86581f7..14dbe27 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -49,6 +49,7 @@ CONFIG_ARCH_UNIPHIER=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_XGENE=y
 CONFIG_ARCH_ZYNQMP=y
+CONFIG_ARCH_LG1K=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_IOV=y
-- 
1.7.9.5
