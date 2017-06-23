From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Fri, 23 Jun 2017 14:55:45 +0200
Subject: [PATCH 3/8] dt-bindings: spi: stm32: fix example with st,
 spi-midi-ns property
In-Reply-To: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
References: <1498222550-19092-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1498222550-19092-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch aligns example with the optional property description.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 415378b..25d2ed6 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -55,6 +55,6 @@ Example:
 			compatible = "spidev";
 			reg = <0>;
 			spi-max-frequency = <4000000>;
-			st,spi-midi = <4000>;
+			st,spi-midi-ns = <4000>;
 		};
 	};
-- 
1.9.1
