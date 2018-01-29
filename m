From: lionel.debieve@st.com (Lionel Debieve)
Date: Mon, 29 Jan 2018 18:05:20 +0100
Subject: [PATCH 4/5] dt-bindings: rng: add clock detection error for stm32
In-Reply-To: <20180129170521.1862-1-lionel.debieve@st.com>
References: <20180129170521.1862-1-lionel.debieve@st.com>
Message-ID: <20180129170521.1862-5-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add optional property to enable the clock detection error
on rng block. It is used to allow slow clock source which
give correct entropy for rng.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 Documentation/devicetree/bindings/rng/st,stm32-rng.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rng/st,stm32-rng.txt b/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
index cb7ca78135ff..1dfa7d51e006 100644
--- a/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
+++ b/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
@@ -13,6 +13,7 @@ Required properties:
 
 Optional properties:
 - resets : The reset to properly start RNG
+- clock-error-detect : Enable the clock detection management
 
 Example:
 
-- 
2.15.1
