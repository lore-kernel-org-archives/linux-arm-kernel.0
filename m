From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 17:59:58 +0900
Subject: [PATCH v4 15/19] ARM: shmobile: marzen: Add to shmobile defconfig
In-Reply-To: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
References: <1394701202-25823-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1394701202-25823-16-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add marzen to shmobile defconfig now that it supports multiplatform

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 2a27d46..1d8e10a 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -9,11 +9,13 @@ CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_ARCH_SHMOBILE_MULTI=y
+CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_R8A7791=y
 CONFIG_MACH_KOELSCH=y
 CONFIG_MACH_LAGER=y
+CONFIG_MACH_MARZEN=y
 # CONFIG_SWP_EMULATE is not set
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
-- 
1.8.5.2
