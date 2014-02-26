From: mohun106@gmail.com (mohun106 at gmail.com)
Date: Wed, 26 Feb 2014 11:32:51 +0530
Subject: [PATCH 1/2] arm64: Add Kconfig option for Cavium Thunder SoC Family
In-Reply-To: <1393394572-6269-1-git-send-email-mohun106@gmail.com>
References: <1393394572-6269-1-git-send-email-mohun106@gmail.com>
Message-ID: <1393394572-6269-2-git-send-email-mohun106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>

This patch adds support for Cavium Thunder SoC Family.

Signed-off-by: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
---
 arch/arm64/Kconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4494327..4161f02 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -130,6 +130,12 @@ config ARCH_XGENE
 	help
 	  This enables support for AppliedMicro X-Gene SOC Family
 
+config ARCH_THUNDER
+	bool "Cavium Inc. Thunder SoC Family"
+	select ARCH_SUPPORTS_48BIT_PA
+	help
+	  This enables support for Cavium's Thunder Family of SoCs
+
 endmenu
 
 menu "Bus support"
-- 
1.7.1
