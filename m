From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 27 May 2017 18:23:00 +0800
Subject: [PATCH v3 02/10] pinctrl: sunxi: Add SoC ID definitions for A10,
 A20 and R40 SoCs
In-Reply-To: <20170527102308.1988-1-icenowy@aosc.io>
References: <20170527102308.1988-1-icenowy@aosc.io>
Message-ID: <20170527102308.1988-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A10, A20 and R40 SoCs have similar GPIO layout.

Add SoC definitions in pinctrl-sunxi.h, in order to merge A20 support
into A10 driver, and add R40 support into it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v3:
- Commit message change.

 drivers/pinctrl/sunxi/pinctrl-sunxi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.h b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
index a9d315a1256c..1bfc0d8a55df 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.h
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.h
@@ -87,6 +87,9 @@
 #define PINCTRL_SUN5I_GR8	BIT(3)
 #define PINCTRL_SUN6I_A31	BIT(4)
 #define PINCTRL_SUN6I_A31S	BIT(5)
+#define PINCTRL_SUN4I_A10	BIT(6)
+#define PINCTRL_SUN7I_A20	BIT(7)
+#define PINCTRL_SUN8I_R40	BIT(8)
 
 struct sunxi_desc_function {
 	unsigned long	variant;
-- 
2.12.2
