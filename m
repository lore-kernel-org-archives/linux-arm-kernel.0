From: lionel.debieve@st.com (Lionel Debieve)
Date: Thu, 15 Feb 2018 14:03:09 +0100
Subject: [PATCH Resend 2/5] dt-bindings: rng: add reset node for stm32
In-Reply-To: <20180215130312.23612-1-lionel.debieve@st.com>
References: <20180215130312.23612-1-lionel.debieve@st.com>
Message-ID: <20180215130312.23612-3-lionel.debieve@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding optional resets property for rng.

Signed-off-by: Lionel Debieve <lionel.debieve@st.com>
---
 Documentation/devicetree/bindings/rng/st,stm32-rng.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rng/st,stm32-rng.txt b/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
index 47f04176f93b..cb7ca78135ff 100644
--- a/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
+++ b/Documentation/devicetree/bindings/rng/st,stm32-rng.txt
@@ -11,6 +11,9 @@ Required properties:
 - interrupts : The designated IRQ line for the RNG
 - clocks : The clock needed to enable the RNG
 
+Optional properties:
+- resets : The reset to properly start RNG
+
 Example:
 
 	rng: rng at 50060800 {
-- 
2.15.1
