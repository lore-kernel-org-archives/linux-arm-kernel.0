From: b29396@freescale.com (Dong Aisheng)
Date: Sat, 12 Nov 2011 00:09:05 +0800
Subject: [PATCH 1/2] ARM: mxs/tx28: add __initconst for fec pdata
Message-ID: <1321027746-5906-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 arch/arm/mach-mxs/module-tx28.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mxs/module-tx28.c b/arch/arm/mach-mxs/module-tx28.c
index 0fcff47..9a7b08b 100644
--- a/arch/arm/mach-mxs/module-tx28.c
+++ b/arch/arm/mach-mxs/module-tx28.c
@@ -66,11 +66,11 @@ static const iomux_cfg_t tx28_fec1_pads[] __initconst = {
 	MX28_PAD_ENET0_CRS__ENET1_RX_EN,
 };
 
-static struct fec_platform_data tx28_fec0_data = {
+static const struct fec_platform_data tx28_fec0_data __initconst = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
-static struct fec_platform_data tx28_fec1_data = {
+static const struct fec_platform_data tx28_fec1_data __initconst = {
 	.phy = PHY_INTERFACE_MODE_RMII,
 };
 
-- 
1.7.0.4
