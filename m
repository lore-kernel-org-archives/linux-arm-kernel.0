From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:34:18 +0900
Subject: [PATCH 7/8] ARM: shmobile: r8a7778: add USBHS clock
In-Reply-To: <cover.1380530437.git.horms+renesas@verge.net.au>
References: <cover.1380530437.git.horms+renesas@verge.net.au>
Message-ID: <84ea52885ebb298231b9577dd8b53fdfa692c0b7.1380530437.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds USBHS clock for renesas_usbhs driver

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7778.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 244a8de..fb6af83 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -181,6 +181,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a7778-vin.1", &mstp_clks[MSTP109]), /* VIN1 */
 	CLKDEV_DEV_ID("ehci-platform", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
 	CLKDEV_DEV_ID("ohci-platform", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
+	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP100]), /* USB FUNC */
 	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
 	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
 	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP028]), /* I2C2 */
-- 
1.8.4
