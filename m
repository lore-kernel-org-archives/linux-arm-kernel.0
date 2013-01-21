From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 21 Jan 2013 18:54:00 +0100
Subject: [PATCH 4/6] arm: mvebu: update defconfig with local timer support
In-Reply-To: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1358790842-2986-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have support for local timers, enable it by default

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index b5bc96c..28c1e38 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -14,7 +14,6 @@ CONFIG_MACH_ARMADA_XP=y
 # CONFIG_CACHE_L2X0 is not set
 # CONFIG_SWP_EMULATE is not set
 CONFIG_SMP=y
-# CONFIG_LOCAL_TIMERS is not set
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 # CONFIG_COMPACTION is not set
-- 
1.7.9.5
