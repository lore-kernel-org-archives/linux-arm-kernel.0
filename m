From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 14:47:49 +0530
Subject: [PATCH 4/9] pinctrl: SPEAr1310: fix clcd high resolution pin group
 name
In-Reply-To: <cover.1351329224.git.viresh.kumar@linaro.org>
References: <cover.1351329224.git.viresh.kumar@linaro.org>
Message-ID: <15832cbb66c39a79bae5c42feae12cd30207cd45.1351329224.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

All group names in SPEAr pinctrl have "_grp" at the end of their name. Do the
same for clcd_high_res_grp.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/pinctrl/spear/pinctrl-spear1310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index d6cca8c..c720d09 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -461,7 +461,7 @@ static struct spear_pingroup clcd_high_res_pingroup = {
 	.nmodemuxs = ARRAY_SIZE(clcd_high_res_modemux),
 };
 
-static const char *const clcd_grps[] = { "clcd_grp", "clcd_high_res" };
+static const char *const clcd_grps[] = { "clcd_grp", "clcd_high_res_grp" };
 static struct spear_function clcd_function = {
 	.name = "clcd",
 	.groups = clcd_grps,
-- 
1.7.12.rc2.18.g61b472e
