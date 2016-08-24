From: guodong.xu@linaro.org (Guodong Xu)
Date: Wed, 24 Aug 2016 10:42:06 +0800
Subject: [PATCH v2 2/3] arm64: defconfig: enable CONFIG_INPUT_HISI_POWERKEY
 for HiKey
In-Reply-To: <1472006527-30620-1-git-send-email-guodong.xu@linaro.org>
References: <1472006527-30620-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1472006527-30620-3-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e27f086..b4f714c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -186,6 +186,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
+CONFIG_INPUT_HISI_POWERKEY=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
-- 
1.9.1
