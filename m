From: lkp@intel.com (kbuild test robot)
Date: Wed, 21 Feb 2018 23:05:29 +0800
Subject: [RFC PATCH] drm/panel: lhr050h41_init[] can be static
In-Reply-To: <33efcb267bc513bb19551f1ffdcf578ebfb90369.1519204731.git-series.maxime.ripard@bootlin.com>
References: <33efcb267bc513bb19551f1ffdcf578ebfb90369.1519204731.git-series.maxime.ripard@bootlin.com>
Message-ID: <20180221150529.GA934@lkp-wsm-ep2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: dcfac3b68dfb ("drm/panel: Add Huarui LHR050H41 panel driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 panel-huarui-lhr050h41.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-huarui-lhr050h41.c b/drivers/gpu/drm/panel/panel-huarui-lhr050h41.c
index f73d484..f71030e 100644
--- a/drivers/gpu/drm/panel/panel-huarui-lhr050h41.c
+++ b/drivers/gpu/drm/panel/panel-huarui-lhr050h41.c
@@ -66,7 +66,7 @@ struct lhr050h41_instr {
 		},					\
 	}
 
-struct lhr050h41_instr lhr050h41_init[] = {
+static struct lhr050h41_instr lhr050h41_init[] = {
 	LHR050H41_SWITCH_PAGE_INSTR(3),
 	LHR050H41_COMMAND_INSTR(0x01, 0x00),
 	LHR050H41_COMMAND_INSTR(0x02, 0x00),
