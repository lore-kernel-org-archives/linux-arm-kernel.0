From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 12 Feb 2014 14:41:22 +0100
Subject: [PATCH v3 08/11] watchdog: xilinx: Use correct comment indentation
In-Reply-To: <bdd7c2c78dd491d02d1c1ae8a59b92b7a1a17ec6.1392212059.git.michal.simek@xilinx.com>
References: <bdd7c2c78dd491d02d1c1ae8a59b92b7a1a17ec6.1392212059.git.michal.simek@xilinx.com>
Message-ID: <96c6acc9bf5f41b0fc37c6b17b2d07239c5b6101.1392212059.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional changes.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Changes in v3: None
Changes in v2: None

 drivers/watchdog/of_xilinx_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 7deea21..9dd16cf 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -190,10 +190,10 @@ static int xwdt_probe(struct platform_device *pdev)

 	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);

-/*
- *  Twice of the 2^wdt_interval / freq  because the first wdt overflow is
- *  ignored (interrupt), reset is only generated at second wdt overflow
- */
+	/*
+	 * Twice of the 2^wdt_interval / freq  because the first wdt overflow is
+	 * ignored (interrupt), reset is only generated at second wdt overflow
+	 */
 	if (!no_timeout)
 		xilinx_wdt_wdd->timeout = 2 * ((1 << xdev->wdt_interval) /
 					  pfreq);
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/35b68b9c/attachment.sig>
