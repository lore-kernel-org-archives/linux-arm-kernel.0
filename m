From: pushkar.iit@gmail.com (Pushkar Jambhlekar)
Date: Wed, 15 Mar 2017 12:01:08 +0530
Subject: [PATCH] vc04_services: Fixing coding guideline error
Message-ID: <1489559468-46932-1-git-send-email-pushkar.iit@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing 'if' block coding style. '{' should follow 'if' for multiline block

Signed-off-by: Pushkar Jambhlekar <pushkar.iit@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 48984ab..ca896a5 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -797,8 +797,7 @@ int32_t vchi_get_peer_version(const VCHI_SERVICE_HANDLE_T handle, short *peer_ve
 {
 	int32_t ret = -1;
 	SHIM_SERVICE_T *service = (SHIM_SERVICE_T *)handle;
-	if (service)
-	{
+	if (service) {
 		VCHIQ_STATUS_T status;
 
 		status = vchiq_get_peer_version(service->handle, peer_version);
-- 
2.7.4
