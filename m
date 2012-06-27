From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 27 Jun 2012 17:26:44 +0100
Subject: [PATCH 1/3] arm: mach-mvebu: fixup style error in system-controller
In-Reply-To: <1340814406-26010-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <1340814406-26010-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1340814406-26010-2-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixup the of_match_table indentation and missing , on the end.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/system-controller.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 14331ba..f39023b 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -53,10 +53,13 @@ const struct mvebu_system_controller orion_system_controller = {
 };
 
 static struct of_device_id of_system_controller_table[] = {
-	{.compatible = "marvell,orion-system-controller",
-	 .data = (void *) &orion_system_controller},
-	{.compatible = "marvell,armada-370-xp-system-controller",
-	 .data = (void *) &armada_370_xp_system_controller},
+	{
+		.compatible = "marvell,orion-system-controller",
+		.data = (void *) &orion_system_controller,
+	}, {
+		.compatible = "marvell,armada-370-xp-system-controller",
+		.data = (void *) &armada_370_xp_system_controller,
+	},
 	{ /* end of list */ },
 };
 
-- 
1.7.10
