From: desrt@desrt.ca (Ryan Lortie)
Date: Sat, 26 Feb 2011 19:41:53 -0500
Subject: [PATCH 2/2] ARM: imx35: fix trivial copy/paste error
In-Reply-To: <1298767313-16351-1-git-send-email-desrt@desrt.ca>
References: <1298767313-16351-1-git-send-email-desrt@desrt.ca>
Message-ID: <1298767313-16351-3-git-send-email-desrt@desrt.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change imx31_add_imx_keypad() to imx35_add_imx_keypad() in
mach-mx3/devices-imx35.h.

Signed-off-by: Ryan Lortie <desrt@desrt.ca>
---
 arch/arm/mach-mx3/devices-imx35.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index 677b18a..d545d86 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -35,7 +35,7 @@ extern const struct imx_imx_i2c_data imx35_imx_i2c_data[] __initconst;
 #define imx35_add_imx_i2c2(pdata)	imx35_add_imx_i2c(2, pdata)
 
 extern const struct imx_imx_keypad_data imx35_imx_keypad_data __initconst;
-#define imx31_add_imx_keypad(pdata)	\
+#define imx35_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx35_imx_keypad_data, pdata)
 
 extern const struct imx_imx_ssi_data imx35_imx_ssi_data[] __initconst;
-- 
1.7.4.1
