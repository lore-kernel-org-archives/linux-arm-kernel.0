From: lameli67@gmail.com (Mikhail Shvetsov)
Date: Thu, 14 Dec 2017 23:40:05 +0300
Subject: [PATCH 3/3] staging: vchiq_arm: Fixing code lines over 80 characters
In-Reply-To: <cover.1513283180.git.lameli67@gmail.com>
References: <cover.1513283180.git.lameli67@gmail.com>
Message-ID: <5308367c586cf7cce4ef4e2f96af966de457785c.1513283180.git.lameli67@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mikhail Shvetsov <lameli67@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
index 48f05062fc12..7a803d136987 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
@@ -87,7 +87,8 @@ VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 		goto failed;
 	} else if (i > 0) {
 		vchiq_log_warning(vchiq_core_log_level,
-			"%s: videocore initialized after %d retries\n", __func__, i);
+			"%s: videocore initialized after %d retries\n",
+			__func__, i);
 	}
 
 	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
-- 
2.11.0
