From: krishna.md@samsung.com (Krishna Mohan Dani)
Date: Mon, 27 Oct 2014 11:41:10 +0530
Subject: [PATCH 3/4] Sound: Kconfig: Adding the description of the codec
In-Reply-To: <1414390271-25040-1-git-send-email-krishna.md@samsung.com>
References: <1414390271-25040-1-git-send-email-krishna.md@samsung.com>
Message-ID: <1414390271-25040-4-git-send-email-krishna.md@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>
---
 sound/soc/codecs/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a68d173..2d85887 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -487,7 +487,8 @@ config SND_SOC_RT286
 	depends on I2C
 
 config SND_SOC_RT5631
-	tristate
+	tristate "Realtek ALC5631 CODEC"
+	depends on I2C
 
 config SND_SOC_RT5640
 	tristate
-- 
1.7.9.5
