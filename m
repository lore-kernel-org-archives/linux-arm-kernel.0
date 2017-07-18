From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 18 Jul 2017 06:59:04 +0200
Subject: [PATCH v2 2/5] ARM: ixp4xx_defconfig: Cleanup from non-existing
 options
In-Reply-To: <1500353947-26122-1-git-send-email-krzk@kernel.org>
References: <1500353947-26122-1-git-send-email-krzk@kernel.org>
Message-ID: <1500353947-26122-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove options which do not exist anymore:
 - ECONET is gone since commit 349f29d841db ("econet: remove ancient bug
   ridden protocol");

 - IPDDP_DECAP is gone since commit 9b5645b51384 ("appletalk: remove
   "config IPDDP_DECAP"");

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/configs/ixp4xx_defconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index c8378da71913..8c3c99cd6de9 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -81,12 +81,8 @@ CONFIG_ATALK=m
 CONFIG_DEV_APPLETALK=m
 CONFIG_IPDDP=m
 CONFIG_IPDDP_ENCAP=y
-CONFIG_IPDDP_DECAP=y
 CONFIG_X25=m
 CONFIG_LAPB=m
-CONFIG_ECONET=m
-CONFIG_ECONET_AUNUDP=y
-CONFIG_ECONET_NATIVE=y
 CONFIG_WAN_ROUTER=m
 CONFIG_NET_SCHED=y
 CONFIG_NET_SCH_CBQ=m
-- 
2.7.4
