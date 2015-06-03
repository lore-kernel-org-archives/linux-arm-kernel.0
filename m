From: tony@atomide.com (Tony Lindgren)
Date: Wed,  3 Jun 2015 09:23:11 -0700
Subject: [PATCH 02/12] ARM: OMAP2+: Fix scrm compatible for dm814x
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Message-ID: <1433348601-8966-3-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix scrm compatible for dm814x.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/control.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index af95a62..364925c 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -649,6 +649,7 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am4-scm", .data = &ctrl_data },
 	{ .compatible = "ti,omap2-scm", .data = &omap2_ctrl_data },
 	{ .compatible = "ti,omap3-scm", .data = &omap2_ctrl_data },
+	{ .compatible = "ti,dm814-scm", .data = &ctrl_data },
 	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap4-scm-core", .data = &ctrl_data },
 	{ .compatible = "ti,omap5-scm-core", .data = &ctrl_data },
-- 
2.1.4
