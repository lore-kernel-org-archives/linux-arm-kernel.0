From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 19 Jan 2012 22:35:05 +0100
Subject: [PATCH] Documentation/pinctrl: fix a few syntax errors in code
 examples
In-Reply-To: <1323383765-30742-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1323383765-30742-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1327008905-20544-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this is what's left from the patch I sent in the mail with message-id
1323383765-30742-1-git-send-email-u.kleine-koenig at pengutronix.de after
rebasing to current linus/master. The original submission got an ack by
Stephen Warren that I assumed for this patch, too.

Best regards
Uwe

 Documentation/pinctrl.txt |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/pinctrl.txt b/Documentation/pinctrl.txt
index 6727b92..5324d31 100644
--- a/Documentation/pinctrl.txt
+++ b/Documentation/pinctrl.txt
@@ -857,42 +857,41 @@ case), we define a mapping like this:
 
 ...
 {
-	.name "2bit"
+	.name = "2bit"
 	.ctrl_dev_name = "pinctrl-foo",
 	.function = "mmc0",
 	.group = "mmc0_1_grp",
 	.dev_name = "foo-mmc.0",
 },
 {
-	.name "4bit"
+	.name = "4bit"
 	.ctrl_dev_name = "pinctrl-foo",
 	.function = "mmc0",
 	.group = "mmc0_1_grp",
 	.dev_name = "foo-mmc.0",
 },
 {
-	.name "4bit"
+	.name = "4bit"
 	.ctrl_dev_name = "pinctrl-foo",
 	.function = "mmc0",
 	.group = "mmc0_2_grp",
 	.dev_name = "foo-mmc.0",
 },
 {
-	.name "8bit"
+	.name = "8bit"
 	.ctrl_dev_name = "pinctrl-foo",
-	.function = "mmc0",
 	.group = "mmc0_1_grp",
 	.dev_name = "foo-mmc.0",
 },
 {
-	.name "8bit"
+	.name = "8bit"
 	.ctrl_dev_name = "pinctrl-foo",
 	.function = "mmc0",
 	.group = "mmc0_2_grp",
 	.dev_name = "foo-mmc.0",
 },
 {
-	.name "8bit"
+	.name = "8bit"
 	.ctrl_dev_name = "pinctrl-foo",
 	.function = "mmc0",
 	.group = "mmc0_3_grp",
@@ -995,7 +994,7 @@ This is enabled by simply setting the .hog_on_boot field in the map to true,
 like this:
 
 {
-	.name "POWERMAP"
+	.name = "POWERMAP"
 	.ctrl_dev_name = "pinctrl-foo",
 	.function = "power_func",
 	.hog_on_boot = true,
-- 
1.7.8.3
