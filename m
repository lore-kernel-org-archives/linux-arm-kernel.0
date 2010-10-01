From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri,  1 Oct 2010 14:29:53 -0700
Subject: [PATCH 29/47] davinci: add idcode for tnetv107x rev 1.1/1.2
In-Reply-To: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
References: <1285968611-26890-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285968611-26890-30-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

This patch adds an entry into the idcode table for tnetv107x silicon revision
1.1 and 1.2 devices.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/tnetv107x.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/tnetv107x.c b/arch/arm/mach-davinci/tnetv107x.c
index 06d2ac9..daeae06 100644
--- a/arch/arm/mach-davinci/tnetv107x.c
+++ b/arch/arm/mach-davinci/tnetv107x.c
@@ -581,7 +581,14 @@ static struct davinci_id ids[] = {
 		.part_no	= 0xb8a1,
 		.manufacturer	= 0x017,
 		.cpu_id		= DAVINCI_CPU_ID_TNETV107X,
-		.name		= "tnetv107x rev1.0",
+		.name		= "tnetv107x rev 1.0",
+	},
+	{
+		.variant	= 0x1,
+		.part_no	= 0xb8a1,
+		.manufacturer	= 0x017,
+		.cpu_id		= DAVINCI_CPU_ID_TNETV107X,
+		.name		= "tnetv107x rev 1.1/1.2",
 	},
 };
 
-- 
1.7.2.1
