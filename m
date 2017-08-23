From: cl@rock-chips.com (cl at rock-chips.com)
Date: Wed, 23 Aug 2017 16:40:31 +0800
Subject: [PATCH v1 2/3] cpufreq: rockchip: add support for rk3328 soc
In-Reply-To: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
References: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
Message-ID: <1503477632-9661-3-git-send-email-cl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Liang Chen <cl@rock-chips.com>

Add compatible rockchip,rk3328 to the machines table to
launch cpufreq-dt driver for rk3328 soc.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1c26292..f16c3ba 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -76,6 +76,7 @@
 	{ .compatible = "rockchip,rk3188", },
 	{ .compatible = "rockchip,rk3228", },
 	{ .compatible = "rockchip,rk3288", },
+	{ .compatible = "rockchip,rk3328", },
 	{ .compatible = "rockchip,rk3366", },
 	{ .compatible = "rockchip,rk3368", },
 	{ .compatible = "rockchip,rk3399", },
-- 
1.9.1
