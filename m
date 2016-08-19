From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri, 19 Aug 2016 23:42:07 +0800
Subject: [PATCH 3/4] arm64: defconfig: enable CONFIG_INPUT_HISI_POWERKEY for
 HiKey
In-Reply-To: <1471621328-21102-1-git-send-email-guodong.xu@linaro.org>
References: <1471621328-21102-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1471621328-21102-4-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c94f2fa..11a79ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -187,6 +187,7 @@ CONFIG_INPUT_EVDEV=y
 CONFIG_KEYBOARD_GPIO=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
+CONFIG_INPUT_HISI_POWERKEY=y
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIO_AMBAKMI=y
 CONFIG_LEGACY_PTY_COUNT=16
-- 
1.9.1
