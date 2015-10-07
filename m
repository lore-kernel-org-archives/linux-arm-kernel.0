From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  7 Oct 2015 13:23:27 +0100
Subject: [PATCH v2 1/3] hwrng: st: dt: Fix trivial typo in node address
In-Reply-To: <1444220609-31251-1-git-send-email-lee.jones@linaro.org>
References: <1444220609-31251-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1444220609-31251-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT nodes should not append their addresses with '0x'.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/rng/st,rng.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rng/st,rng.txt b/Documentation/devicetree/bindings/rng/st,rng.txt
index dbc64e6..35734bc 100644
--- a/Documentation/devicetree/bindings/rng/st,rng.txt
+++ b/Documentation/devicetree/bindings/rng/st,rng.txt
@@ -8,7 +8,7 @@ clocks		: Phandle to device's clock (See: ../clocks/clock-bindings.txt)
 
 Example:
 
-rng at 0xfee80000 {
+rng at fee80000 {
 	compatible      = "st,rng";
 	reg		= <0xfee80000 0x1000>;
 	clocks          = <&clk_sysin>;
-- 
1.9.1
