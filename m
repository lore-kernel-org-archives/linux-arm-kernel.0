From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 15:42:04 +0530
Subject: [PATCH V2 2/5] pinctrl: SPEAr1310: Fix pin numbers for clcd_high_res
In-Reply-To: <cover.1336039716.git.viresh.kumar@st.com>
References: <cover.1336039716.git.viresh.kumar@st.com>
Message-ID: <b365695bcaf78a228dd5739df4d25fc3fe5e1143.1336039716.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/pinctrl/spear/pinctrl-spear1310.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index 12b094d..fff168b 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -437,7 +437,7 @@ static struct spear_pingroup clcd_pingroup = {
 };
 
 static const unsigned clcd_high_res_pins[] = { 30, 31, 32, 33, 34, 35, 36, 37,
-	38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52 };
+	38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53 };
 static struct spear_muxreg clcd_high_res_muxreg[] = {
 	{
 		.reg = PAD_FUNCTION_EN_1,
-- 
1.7.9
