From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:34 +0100
Subject: [PATCH 37/41] ARM: ux500: Remove AUXDATA relating to Ethernet
 clock-name bindings
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-38-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/cpu-db8500.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 7e32c7b..689d3a8 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -235,7 +235,6 @@ static struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	/* Requires clock name bindings. */
 	OF_DEV_AUXDATA("stericsson,db8500-prcmu", 0x80157000, "db8500-prcmu",
 			&db8500_prcmu_pdata),
-	OF_DEV_AUXDATA("smsc,lan9115", 0x50000000, "smsc911x.0", NULL),
 	OF_DEV_AUXDATA("stericsson,ux500-cryp", 0xa03cb000, "cryp1", NULL),
 	OF_DEV_AUXDATA("stericsson,ux500-hash", 0xa03c2000, "hash1", NULL),
 	OF_DEV_AUXDATA("stericsson,snd-soc-mop500", 0, "snd-soc-mop500.0",
-- 
1.8.1.2
