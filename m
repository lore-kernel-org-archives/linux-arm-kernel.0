From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Mon, 24 Mar 2014 14:39:37 +0530
Subject: [PATCH v2 1/3] arm64: Add Kconfig option for Cavium Thunder SoC Family
In-Reply-To: <1395652179-9216-1-git-send-email-mohun106@gmail.com>
References: <1395652179-9216-1-git-send-email-mohun106@gmail.com>
Message-ID: <1395652179-9216-2-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch adds support in Kconfig to select Cavium Thunder platform.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
---
 arch/arm64/Kconfig |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a3c40d6..e899a7d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -113,6 +113,11 @@ source "kernel/Kconfig.freezer"
 
 menu "Platform selection"
 
+config ARCH_THUNDER
+	bool "Cavium Inc. Thunder SoC Family"
+	help
+	  This enables support for Cavium's Thunder Family of SoCs
+
 config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
 	select ARCH_REQUIRE_GPIOLIB
-- 
1.7.1
