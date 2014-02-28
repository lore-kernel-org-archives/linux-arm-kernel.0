From: maxime.coquelin@st.com (Maxime COQUELIN)
Date: Fri, 28 Feb 2014 13:17:18 +0100
Subject: [PATCH 2/5] ARM: STi: add pinctrl support for the STiH407 SoC
In-Reply-To: <1393589841-6634-1-git-send-email-maxime.coquelin@st.com>
References: <1393589841-6634-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1393589841-6634-3-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Giuseppe Cavallaro <peppe.cavallaro@st.com>

This patch adds the initial support for pinctrl based on H407 SoC.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/pinctrl/pinctrl-st.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
index 320c273..f95eecf 100644
--- a/drivers/pinctrl/pinctrl-st.c
+++ b/drivers/pinctrl/pinctrl-st.c
@@ -1264,6 +1264,10 @@ static struct of_device_id st_pctl_of_match[] = {
 	{ .compatible = "st,stih416-rear-pinctrl", .data = &stih416_data},
 	{ .compatible = "st,stih416-fvdp-fe-pinctrl", .data = &stih416_data},
 	{ .compatible = "st,stih416-fvdp-lite-pinctrl", .data = &stih416_data},
+	{ .compatible = "st,stih407-sbc-pinctrl", .data = &stih416_data},
+	{ .compatible = "st,stih407-front-pinctrl", .data = &stih416_data},
+	{ .compatible = "st,stih407-rear-pinctrl", .data = &stih416_data},
+	{ .compatible = "st,stih407-flash-pinctrl", .data = &stih416_data},
 	{ /* sentinel */ }
 };
 
-- 
1.9.0
