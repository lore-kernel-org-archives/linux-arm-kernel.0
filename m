From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 20 Mar 2013 19:36:28 -0300
Subject: [PATCH 07/16] thermal: mvebu: Fix license declaration
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1363818997-23137-8-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The license text declared in the header explicit says GPL v2 only,
but the MODULE_LICENSE macro says GPL, which means GPL v2 or later. Fix it.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index 089b43d..5886a9c 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -128,4 +128,4 @@ module_platform_driver(mvebu_thermal_driver);
 
 MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
 MODULE_DESCRIPTION("mvebu thermal driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
1.7.8.6
