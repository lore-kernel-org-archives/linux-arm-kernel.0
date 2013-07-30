From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 10:59:01 +0900
Subject: [PATCH 2/4] ARM: shmobile: ape6evm: Enable gpio-keys in defconfig
In-Reply-To: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
References: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1375149543-27564-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/ape6evm_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
index dab5a7d..e4359c7 100644
--- a/arch/arm/configs/ape6evm_defconfig
+++ b/arch/arm/configs/ape6evm_defconfig
@@ -54,7 +54,8 @@ CONFIG_NETDEVICES=y
 CONFIG_SMC91X=y
 CONFIG_SMSC911X=y
 # CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_SERIAL_NONSTANDARD=y
-- 
1.8.3.2
