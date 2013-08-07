From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:24:21 +0900
Subject: [GIT PULL 4/4] ARM: shmobile: ape6evm: Enable gpio-leds in defconfig
In-Reply-To: <cover.1375842392.git.horms+renesas@verge.net.au>
References: <cover.1375842392.git.horms+renesas@verge.net.au>
Message-ID: <461cd47a65f5d8513a983ebd21ef7c23d4b4730f.1375842392.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/ape6evm_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
index e4359c7..1ce3994 100644
--- a/arch/arm/configs/ape6evm_defconfig
+++ b/arch/arm/configs/ape6evm_defconfig
@@ -72,6 +72,9 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_GPIO=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 CONFIG_TMPFS=y
-- 
1.8.3.2
