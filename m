From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  7 Mar 2017 14:31:00 +0100
Subject: [PATCH 1/3] pinctrl: meson-gxbb: Fix typo in i2c ao groups
In-Reply-To: <1488893462-7016-1-git-send-email-narmstrong@baylibre.com>
References: <1488893462-7016-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1488893462-7016-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 7671424..31a3a98 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -667,11 +667,11 @@
 };
 
 static const char * const i2c_ao_groups[] = {
-	"i2c_sdk_ao", "i2c_sda_ao",
+	"i2c_sck_ao", "i2c_sda_ao",
 };
 
 static const char * const i2c_slave_ao_groups[] = {
-	"i2c_slave_sdk_ao", "i2c_slave_sda_ao",
+	"i2c_slave_sck_ao", "i2c_slave_sda_ao",
 };
 
 static const char * const remote_input_ao_groups[] = {
-- 
1.9.1
