From: yannick.fertre@st.com (Yannick Fertre)
Date: Fri, 10 Feb 2017 16:24:30 +0100
Subject: [PATCH v2 3/7] dt-bindings: Add Ampire AM-480272H3TMQW-T01H panel
In-Reply-To: <1486740274-25958-1-git-send-email-yannick.fertre@st.com>
References: <1486740274-25958-1-git-send-email-yannick.fertre@st.com>
Message-ID: <1486740274-25958-4-git-send-email-yannick.fertre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Yannick Fertre <yannick.fertre@st.com>
---
 .../bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt         | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt

diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
new file mode 100644
index 0000000..f59e3c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
@@ -0,0 +1,7 @@
+Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "ampire,am-480272h3tmqw-t01h"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
1.9.1
