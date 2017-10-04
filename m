From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Wed,  4 Oct 2017 23:25:21 +0100
Subject: [RESEND][PATCH 7/7] nvmem: imx-ocotp: Update module description
In-Reply-To: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
References: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507155921-824-8-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This imx-ocotp driver encapsulates support for a subset of both i.MX6 and
i.MX7 processors. Update the module description to reflect.

Fixes: 711d45477931 ("nvmem: octop: Add i.MX7D support")

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 5b0f7b5..a58a80b 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -496,5 +496,5 @@ static struct platform_driver imx_ocotp_driver = {
 module_platform_driver(imx_ocotp_driver);
 
 MODULE_AUTHOR("Philipp Zabel <p.zabel@pengutronix.de>");
-MODULE_DESCRIPTION("i.MX6 OCOTP fuse box driver");
+MODULE_DESCRIPTION("i.MX6/i.MX7 OCOTP fuse box driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4
