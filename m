From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  6 Mar 2018 17:17:42 +0100
Subject: [PATCH] meson-gx-socinfo: Add package id for S905H
Message-ID: <1520353062-8919-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The S905H can be found on the Wetek Hub and Play2 boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index ea091f1..60fa2de 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -41,6 +41,7 @@ static const struct meson_gx_package_id {
 	unsigned int pack_id;
 } soc_packages[] = {
 	{ "S905", 0x1f, 0 },
+	{ "S905H", 0x1f, 0x13 },
 	{ "S905M", 0x1f, 0x20 },
 	{ "S905D", 0x21, 0 },
 	{ "S905X", 0x21, 0x80 },
-- 
2.7.4
