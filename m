From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Tue, 25 Apr 2017 14:41:09 +0800
Subject: [PATCH V2  1/2] clk: rockchip: add ids for camera
In-Reply-To: <1493102470-22965-1-git-send-email-eddie.cai.linux@gmail.com>
References: <1493102470-22965-1-git-send-email-eddie.cai.linux@gmail.com>
Message-ID: <1493102470-22965-2-git-send-email-eddie.cai.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we use SCLK_TESTCLKOUT1 and SCLK_TESTCLKOUT2 for camera, so add those ids.

Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
---
 include/dt-bindings/clock/rk3399-cru.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/rk3399-cru.h b/include/dt-bindings/clock/rk3399-cru.h
index 220a60f..22cb1df 100644
--- a/include/dt-bindings/clock/rk3399-cru.h
+++ b/include/dt-bindings/clock/rk3399-cru.h
@@ -132,6 +132,8 @@
 #define SCLK_RMII_SRC			166
 #define SCLK_PCIEPHY_REF100M		167
 #define SCLK_DDRC			168
+#define SCLK_TESTCLKOUT1		169
+#define SCLK_TESTCLKOUT2		170
 
 #define DCLK_VOP0			180
 #define DCLK_VOP1			181
-- 
1.9.1
