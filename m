From: Hong-Xing.Zhu@freescale.com (Richard Zhu)
Date: Fri, 18 Mar 2011 17:56:55 +0800
Subject: [PATCH V7 2/4] mmc: add the abort CMDTYE bits definition
In-Reply-To: <1300442217-1060-1-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1300442217-1060-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <1300442217-1060-2-git-send-email-Hong-Xing.Zhu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the abort CMDTYPE bits definition of command register (offset 0xE)

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 drivers/mmc/host/sdhci.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..25e8bde 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -45,6 +45,7 @@
 #define  SDHCI_CMD_CRC		0x08
 #define  SDHCI_CMD_INDEX	0x10
 #define  SDHCI_CMD_DATA		0x20
+#define  SDHCI_CMD_ABORTCMD	0xC0
 
 #define  SDHCI_CMD_RESP_NONE	0x00
 #define  SDHCI_CMD_RESP_LONG	0x01
-- 
1.7.1
