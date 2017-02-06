From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Mon,  6 Feb 2017 10:50:34 +0800
Subject: [PATCH v1 1/2] rockchip: clk: rk3328: add clk_mac2io_ext ID
In-Reply-To: <1486349435-8681-1-git-send-email-zhangqing@rock-chips.com>
References: <1486349435-8681-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <1486349435-8681-2-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 include/dt-bindings/clock/rk3328-cru.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/rk3328-cru.h b/include/dt-bindings/clock/rk3328-cru.h
index ee702c8e4c09..d2b26a4b43eb 100644
--- a/include/dt-bindings/clock/rk3328-cru.h
+++ b/include/dt-bindings/clock/rk3328-cru.h
@@ -97,6 +97,7 @@
 #define SCLK_MAC2IO_SRC		99
 #define SCLK_MAC2IO		100
 #define SCLK_MAC2PHY		101
+#define SCLK_MAC2IO_EXT		102
 
 /* dclk gates */
 #define DCLK_LCDC		120
-- 
1.9.1
