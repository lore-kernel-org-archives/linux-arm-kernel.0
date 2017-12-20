From: lameli67@gmail.com (Mikhail Shvetsov)
Date: Wed, 20 Dec 2017 15:30:16 +0300
Subject: [PATCH 3/3] staging: vchiq_arm: Cleaning up codestyle warnings
In-Reply-To: <8bfad6214b83ee325888705c9f5a194cb6899caf.1513772223.git.lameli67@gmail.com>
References: <8bfad6214b83ee325888705c9f5a194cb6899caf.1513772223.git.lameli67@gmail.com>
Message-ID: <48587b4569f3907aaf5ee29d3275eb838fcaecb1.1513772223.git.lameli67@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes checkpatch.pl warnings:
WARNING: line over 80 characters

Signed-off-by: Mikhail Shvetsov <lameli67@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
index 3c9f97d60019..43c89a08bda9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
@@ -90,7 +90,8 @@ VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
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
