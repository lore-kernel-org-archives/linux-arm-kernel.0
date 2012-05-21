From: Barry.Song@csr.com (Barry Song)
Date: Mon, 21 May 2012 10:59:02 +0800
Subject: [PATCH] pinctrl: sirf: mark of_device_id match table as __devinitconst
Message-ID: <1337569142-18756-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/pinctrl-sirf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 6b3534c..5816cc3 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1192,7 +1192,7 @@ out_no_gpio_remap:
 	return ret;
 }
 
-static const struct of_device_id pinmux_ids[]  = {
+static const struct of_device_id pinmux_ids[] __devinitconst = {
 	{ .compatible = "sirf,prima2-gpio-pinmux" },
 	{}
 };
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
