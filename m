From: michal.simek@xilinx.com (Michal Simek)
Date: Thu,  3 Apr 2014 17:06:57 +0200
Subject: [PATCH] clk: si570: Fix email address specifiction
Message-ID: <07ad0bb4b386c644e70913262b281feb0c2230cb.1396537609.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just fix missing ">" in the email.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/clk/clk-si570.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si570.c b/drivers/clk/clk-si570.c
index 4bbbe32..fc167b3 100644
--- a/drivers/clk/clk-si570.c
+++ b/drivers/clk/clk-si570.c
@@ -526,6 +526,6 @@ static struct i2c_driver si570_driver = {
 module_i2c_driver(si570_driver);

 MODULE_AUTHOR("Guenter Roeck <guenter.roeck@ericsson.com>");
-MODULE_AUTHOR("Soeren Brinkmann <soren.brinkmann at xilinx.com");
+MODULE_AUTHOR("Soeren Brinkmann <soren.brinkmann@xilinx.com>");
 MODULE_DESCRIPTION("Si570 driver");
 MODULE_LICENSE("GPL");
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140403/fd564104/attachment.sig>
