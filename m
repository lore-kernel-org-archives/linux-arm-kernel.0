From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:20:02 +0100
Subject: [PATCH v2 04/23] ARM: Kirkwood: Drop printing the SoC type and
 revision
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392459621-24003-5-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be added back using the mach-mvebu equivelent once the move
has been made.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-kirkwood/board-dt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index e74b31aa9736..a0c0ff39788e 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -107,8 +107,6 @@ eth_fixup_skip:
 
 static void __init kirkwood_dt_init(void)
 {
-	pr_info("Kirkwood: %s.\n", kirkwood_id());
-
 	/*
 	 * Disable propagation of mbus errors to the CPU local bus,
 	 * as this causes mbus errors (which can occur for example
-- 
1.8.5.3
