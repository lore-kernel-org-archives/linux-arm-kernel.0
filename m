From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Fri,  5 Nov 2010 19:17:24 -0600
Subject: [PATCH v2 7/7] omap: mailbox: remove unreachable return
In-Reply-To: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
References: <1289006244-27147-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1289006244-27147-8-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unreachable return statement.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 5e9ea0f..335eb2b 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -434,8 +434,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		return ret;
 	}
 	return 0;
-
-	return ret;
 }
 
 static int __devexit omap2_mbox_remove(struct platform_device *pdev)
-- 
1.7.1
