From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Aug 2013 15:30:28 +0200
Subject: [PATCH 2/3] crypto: dcp - cleanup: commas at end of struct
 initializers where appropriate
In-Reply-To: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
References: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375968629-10091-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/crypto/dcp.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/dcp.c b/drivers/crypto/dcp.c
index a8a7dd4..6a2495e 100644
--- a/drivers/crypto/dcp.c
+++ b/drivers/crypto/dcp.c
@@ -651,8 +651,7 @@ static struct crypto_alg algs[] = {
 			.encrypt = dcp_aes_cbc_encrypt,
 			.decrypt = dcp_aes_cbc_decrypt,
 			.ivsize = AES_KEYSIZE_128,
-		}
-
+		},
 	},
 };
 
@@ -890,8 +889,8 @@ static int dcp_remove(struct platform_device *pdev)
 }
 
 static struct of_device_id fs_dcp_of_match[] = {
-	{	.compatible = "fsl-dcp"},
-	{},
+	{ .compatible = "fsl-dcp", },
+	{}
 };
 
 static struct platform_driver fs_dcp_driver = {
@@ -900,8 +899,8 @@ static struct platform_driver fs_dcp_driver = {
 	.driver = {
 		.name = "fsl-dcp",
 		.owner = THIS_MODULE,
-		.of_match_table = fs_dcp_of_match
-	}
+		.of_match_table = fs_dcp_of_match,
+	},
 };
 
 module_platform_driver(fs_dcp_driver);
-- 
1.7.2.5
