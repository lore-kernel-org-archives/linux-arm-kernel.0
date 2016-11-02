From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed,  2 Nov 2016 10:18:26 +0000
Subject: [PATCH V8 6/6] ARM64: bcm2835: add thermal driver to default_config
In-Reply-To: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1478081906-12009-7-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add the thermal driver for bcm2837 to list of compiled modules
in the default config.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
 V7 -> V8: rebased

---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0..37b2f0a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -271,6 +271,7 @@ CONFIG_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
 CONFIG_CPU_THERMAL=y
+CONFIG_BCM2835_THERMAL=y
 CONFIG_EXYNOS_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_RENESAS_WDT=y
--
2.1.4
