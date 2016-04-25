From: eric@engestrom.ch (Eric Engestrom)
Date: Mon, 25 Apr 2016 01:24:07 +0100
Subject: [PATCH 10/41] Documentation: dt: display: fix spelling mistake
In-Reply-To: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
Message-ID: <1461543878-3639-11-git-send-email-eric@engestrom.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Engestrom <eric@engestrom.ch>
---
 Documentation/devicetree/bindings/display/exynos/exynos_dsim.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/exynos/exynos_dsim.txt b/Documentation/devicetree/bindings/display/exynos/exynos_dsim.txt
index 22756b3..a782659 100644
--- a/Documentation/devicetree/bindings/display/exynos/exynos_dsim.txt
+++ b/Documentation/devicetree/bindings/display/exynos/exynos_dsim.txt
@@ -41,7 +41,7 @@ Video interfaces:
   endpoint node connected from mic node (reg = 0):
     - remote-endpoint: specifies the endpoint in mic node. This node is required
 		       for Exynos5433 mipi dsi. So mic can access to panel node
-		       thoughout this dsi node.
+		       throughout this dsi node.
   endpoint node connected to panel node (reg = 1):
     - remote-endpoint: specifies the endpoint in panel node. This node is
 		       required in all kinds of exynos mipi dsi to represent
-- 
2.8.0
