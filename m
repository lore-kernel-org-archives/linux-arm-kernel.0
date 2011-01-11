From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 11 Jan 2011 20:07:52 +0800
Subject: [PATCH] net/fec: remove config FEC2 as it's used nowhere
In-Reply-To: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
References: <1294297998-26930-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1294747672-4433-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 drivers/net/Kconfig |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index f34629b..24b1b33 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1950,14 +1950,6 @@ config FEC
 	  Say Y here if you want to use the built-in 10/100 Fast ethernet
 	  controller on some Motorola ColdFire and Freescale i.MX processors.
 
-config FEC2
-	bool "Second FEC ethernet controller"
-	depends on FEC
-	help
-	  Say Y here if you want to use the second built-in 10/100 Fast
-	  ethernet controller on some Motorola ColdFire and Freescale
-	  i.MX processors.
-
 config FEC_MPC52xx
 	tristate "MPC52xx FEC driver"
 	depends on PPC_MPC52xx && PPC_BESTCOMM
-- 
1.7.1
