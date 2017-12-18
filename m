From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 18 Dec 2017 16:17:47 +0100
Subject: [PATCH V2 4/9] devicetree: bindings: stm32: add support of STM32MP157
In-Reply-To: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
References: <1513610272-7824-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1513610272-7824-5-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds STM32MP157 SoC bindings.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/devicetree/bindings/arm/stm32.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32.txt
index 05762b0..6808ed9 100644
--- a/Documentation/devicetree/bindings/arm/stm32.txt
+++ b/Documentation/devicetree/bindings/arm/stm32.txt
@@ -7,3 +7,4 @@ using one of the following compatible strings:
   st,stm32f469
   st,stm32f746
   st,stm32h743
+  st,stm32mp157
-- 
2.7.4
