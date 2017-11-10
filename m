From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 10 Nov 2017 16:46:50 +0800
Subject: [PATCH 2/3] reset: meson-axg: add compatible string for Meson-AXG SoC
In-Reply-To: <20171110084650.31325-1-yixun.lan@amlogic.com>
References: <20171110084650.31325-1-yixun.lan@amlogic.com>
Message-ID: <20171110084650.31325-2-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Try to add compatible string explictly to support new Meson-AXG SoC.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/reset/reset-meson.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index c419a3753d00..93cbee1ae8ef 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -139,6 +139,8 @@ static const struct of_device_id meson_reset_dt_ids[] = {
 	   .data = &meson_reset_meson8_ops, },
 	 { .compatible = "amlogic,meson-gxbb-reset",
 	   .data = &meson_reset_gx_ops, },
+	 { .compatible = "amlogic,meson-axg-reset",
+	   .data = &meson_reset_gx_ops, },
 	 { /* sentinel */ },
 };
 
-- 
2.14.1
