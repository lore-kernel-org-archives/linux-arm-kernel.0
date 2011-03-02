From: Hong-Xing.Zhu@freescale.com (Richard Zhu)
Date: Wed, 2 Mar 2011 18:04:40 +0800
Subject: [PATCH V5 3/6] mmc: add the abort CMDTYE bits definition
In-Reply-To: <1299060283-6404-1-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1299060283-6404-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <1299060283-6404-3-git-send-email-Hong-Xing.Zhu@freescale.com>
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
