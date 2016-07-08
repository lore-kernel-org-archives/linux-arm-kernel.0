From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  8 Jul 2016 19:41:12 +0200
Subject: [PATCH] pinctrl: qcom: update DT bindings with ebi2 groups
Message-ID: <1467999672-14259-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the ebi2 and ebi2cs groups to the MSM8660 pin control
documentation document.

Cc: devicetree at vger.kernel.org
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Bj?rn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
index 77aa11790163..df9a838ec5f9 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt
@@ -52,7 +52,7 @@ Valid values for function are:
   gsbi2_spi_cs3_n, gsbi3, gsbi3_spi_cs1_n, gsbi3_spi_cs2_n, gsbi3_spi_cs3_n,
   gsbi4, gsbi5, gsbi6, gsbi7, gsbi8, gsbi9, gsbi10, gsbi11, gsbi12, hdmi, i2s,
   lcdc, mdp_vsync, mi2s, pcm, ps_hold, sdc1, sdc2, sdc5, tsif1, tsif2, usb_fs1,
-  usb_fs1_oe_n, usb_fs2, usb_fs2_oe_n, vfe, vsens_alarm,
+  usb_fs1_oe_n, usb_fs2, usb_fs2_oe_n, vfe, vsens_alarm, ebi2, ebi2cs
 
 Example:
 
-- 
2.7.4
