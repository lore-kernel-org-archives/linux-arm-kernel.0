From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Tue, 17 Sep 2013 10:27:27 +0100
Subject: [PATCH 1/2] ARM: STi: OF: Fix a typo in pincfg header
In-Reply-To: <1379410003-9911-1-git-send-email-srinivas.kandagatla@st.com>
References: <1379410003-9911-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1379410047-9972-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch fixes a typo for OD define in st-pincfg header file.

Reported-by: Maxime Coquelin <maxime.coquelin@st.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/boot/dts/st-pincfg.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/st-pincfg.h b/arch/arm/boot/dts/st-pincfg.h
index 8c45d85..4851c38 100644
--- a/arch/arm/boot/dts/st-pincfg.h
+++ b/arch/arm/boot/dts/st-pincfg.h
@@ -15,7 +15,7 @@
 /* Pull Up */
 #define PU			(1 << 26)
 /* Open Drain */
-#define OD			(1 << 26)
+#define OD			(1 << 25)
 #define RT			(1 << 23)
 #define INVERTCLK		(1 << 22)
 #define CLKNOTDATA		(1 << 21)
-- 
1.7.6.5
