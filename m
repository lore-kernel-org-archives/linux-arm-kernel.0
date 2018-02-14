From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 14 Feb 2018 15:58:55 +0100
Subject: [PATCH] amlogic: meson-gx-socinfo: Update soc ids
Message-ID: <1518620335-17716-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Updates the Amlogic Meson SoCs IDs for the Armv8 based SoCs.
It includes the new families and packages.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index f2d8c3c..a7efe30 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -33,6 +33,10 @@ static const struct meson_gx_soc_id {
 	{ "GXL", 0x21 },
 	{ "GXM", 0x22 },
 	{ "TXL", 0x23 },
+	{ "TXLX", 0x24 },
+	{ "AXG", 0x25 },
+	{ "GXLX", 0x26 },
+	{ "TXHD", 0x27 },
 };
 
 static const struct meson_gx_package_id {
@@ -47,6 +51,10 @@ static const struct meson_gx_package_id {
 	{ "S905L", 0x21, 0xc0 },
 	{ "S905M2", 0x21, 0xe0 },
 	{ "S912", 0x22, 0 },
+	{ "962X", 0x24, 0x10 },
+	{ "962E", 0x24, 0x20 },
+	{ "A113X", 0x25, 0x37 },
+	{ "A113D", 0x25, 0xd0 },
 };
 
 static inline unsigned int socinfo_to_major(u32 socinfo)
-- 
2.7.4
