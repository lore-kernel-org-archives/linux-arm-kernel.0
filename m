From: lars.persson@axis.com (Lars Persson)
Date: Wed, 10 Feb 2016 13:41:56 +0100
Subject: [PATCH 7/8] arm: multi_v7_defconfig: add MACH_ARTPEC6
In-Reply-To: <cover.1455107681.git.larper@axis.com>
References: <cover.1455107681.git.larper@axis.com>
Message-ID: <36d8a6a0236e08bc7286085018e2fa7a67691b39.1455107681.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8e8b2ac..bf3840e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -16,6 +16,8 @@ CONFIG_ARCH_MULTI_V7=y
 # CONFIG_ARCH_MULTI_V4 is not set
 CONFIG_ARCH_VIRT=y
 CONFIG_ARCH_ALPINE=y
+CONFIG_ARCH_ARTPEC=y
+CONFIG_MACH_ARTPEC6=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_375=y
-- 
2.1.4
