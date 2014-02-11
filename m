From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 11 Feb 2014 07:55:51 +0100
Subject: [PATCH v2 08/11] watchdog: xilinx: Use correct comment indentation
In-Reply-To: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
References: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
Message-ID: <12517c3d533eeec7f57e9b9a67c851e39abeb32e.1392101734.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No functional changes.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Changes in v2: None

 drivers/watchdog/of_xilinx_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index bb03e5b..dad8fb5 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -191,10 +191,10 @@ static int xwdt_probe(struct platform_device *pdev)
 	if (enable_once)
 		watchdog_set_nowayout(xilinx_wdt_wdd, true);

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140211/220f1eed/attachment-0001.sig>
