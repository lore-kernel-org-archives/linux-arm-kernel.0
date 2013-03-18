From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:53:20 +0900
Subject: [PATCH 8/9] ARM: shmobile: armadillo800eva: enable all errata for
 cache on defconfig
In-Reply-To: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607601-20366-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Some errata for cache had not enabled on current
Armadillo800eva defconfig.
This patch enables these.
Special thanks to Ishiyama-san

Reported-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 468c616..0f2d80d 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -24,10 +24,15 @@ CONFIG_CACHE_L2X0=y
 CONFIG_ARM_ERRATA_430973=y
 CONFIG_ARM_ERRATA_458693=y
 CONFIG_ARM_ERRATA_460075=y
+CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_720789=y
+CONFIG_PL310_ERRATA_727915=y
 CONFIG_ARM_ERRATA_743622=y
 CONFIG_ARM_ERRATA_751472=y
+CONFIG_PL310_ERRATA_753970=y
 CONFIG_ARM_ERRATA_754322=y
+CONFIG_PL310_ERRATA_769419=y
+CONFIG_ARM_ERRATA_775420=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_FORCE_MAX_ZONEORDER=13
-- 
1.7.10.4
