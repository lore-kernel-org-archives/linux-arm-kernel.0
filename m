From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 13 Oct 2015 23:31:40 +0200
Subject: [PATCH 4/5] pinctrl: berlin: Kconfig clean up
In-Reply-To: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1444771901-24460-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reorder the statements under the PINCTRL_BERLIN_BG4CT config
option to be consistent with the existing.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/pinctrl/berlin/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/berlin/Kconfig b/drivers/pinctrl/berlin/Kconfig
index cf95b4d7f7e3..8fe6ad7795dc 100644
--- a/drivers/pinctrl/berlin/Kconfig
+++ b/drivers/pinctrl/berlin/Kconfig
@@ -21,8 +21,8 @@ config PINCTRL_BERLIN_BG2Q
 	select PINCTRL_BERLIN
 
 config PINCTRL_BERLIN_BG4CT
-	depends on OF
 	bool "Marvell berlin4ct pin controller driver"
+	depends on OF
 	select PINCTRL_BERLIN
 
 endif
-- 
2.6.1
