From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 04 Aug 2014 18:16:33 +0200
Subject: [PATCH] clk: dt-bindings: Fix the assigned clock rates documentation
Message-ID: <1407168994-29382-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct a cut & paste error from commit: 86be408bfbd846fab3c4ac21d6
"clk: Support for clock parents and rates assigned from device tree".

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 .../devicetree/bindings/clock/clock-bindings.txt   |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
index 06fc6d5..bf5b041 100644
--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -138,7 +138,7 @@ Some platforms may require initial configuration of default parent clocks
 and clock frequencies. Such a configuration can be specified in a device tree
 node through assigned-clocks, assigned-clock-parents and assigned-clock-rates
 properties. The assigned-clock-parents property should contain a list of parent
-clocks in form of phandle and clock specifier pairs, the assigned-clock-parents
+clocks in form of phandle and clock specifier pairs, the assigned-clock-rates
 property the list of assigned clock frequency values - corresponding to clocks
 listed in the assigned-clocks property.

--
1.7.9.5
