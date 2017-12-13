From: marek_tomas@centrum.cz (Tomas Marek)
Date: Wed, 13 Dec 2017 12:51:22 -0800
Subject: [PATCH] Staging: vc04_services: fix brace coding style issues in
 vchiq_shim.c
Message-ID: <1513198282-62964-1-git-send-email-marek_tomas@centrum.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix brace on next line coding style errors reported by
checkpatch.

Signed-off-by: Tomas Marek <marek_tomas@centrum.cz>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index d465e1c..29984f9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -800,8 +800,7 @@ int32_t vchi_get_peer_version(const VCHI_SERVICE_HANDLE_T handle, short *peer_ve
 	int32_t ret = -1;
 	struct shim_service *service = (struct shim_service *)handle;
 
-	if (service)
-	{
+	if (service) {
 		VCHIQ_STATUS_T status;
 
 		status = vchiq_get_peer_version(service->handle, peer_version);
-- 
2.7.4
