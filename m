From: lameli67@gmail.com (Mikhail Shvetsov)
Date: Wed, 20 Dec 2017 15:30:14 +0300
Subject: [PATCH 1/3] staging: vchiq_arm: Remove useless comments.
In-Reply-To: <20171214205739.GB1856@kroah.com>
Message-ID: <8bfad6214b83ee325888705c9f5a194cb6899caf.1513772223.git.lameli67@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes useless comments duplicate function names.

Signed-off-by: Mikhail Shvetsov <lameli67@gmail.com>
---
 .../interface/vchiq_arm/vchiq_kern_lib.c           | 35 ----------------------
 1 file changed, 35 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
index 34f746db19cd..6152596d23ea 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
@@ -64,11 +64,6 @@ static VCHIQ_STATUS_T
 vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 	unsigned int size, VCHIQ_BULK_DIR_T dir);
 
-/****************************************************************************
-*
-*   vchiq_initialise
-*
-***************************************************************************/
 #define VCHIQ_INIT_RETRIES 10
 VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 {
@@ -120,12 +115,6 @@ VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 }
 EXPORT_SYMBOL(vchiq_initialise);
 
-/****************************************************************************
-*
-*   vchiq_shutdown
-*
-***************************************************************************/
-
 VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
 {
 	VCHIQ_STATUS_T status;
@@ -168,23 +157,11 @@ VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
 }
 EXPORT_SYMBOL(vchiq_shutdown);
 
-/****************************************************************************
-*
-*   vchiq_is_connected
-*
-***************************************************************************/
-
 static int vchiq_is_connected(VCHIQ_INSTANCE_T instance)
 {
 	return instance->connected;
 }
 
-/****************************************************************************
-*
-*   vchiq_connect
-*
-***************************************************************************/
-
 VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
 {
 	VCHIQ_STATUS_T status;
@@ -214,12 +191,6 @@ VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
 }
 EXPORT_SYMBOL(vchiq_connect);
 
-/****************************************************************************
-*
-*   vchiq_add_service
-*
-***************************************************************************/
-
 VCHIQ_STATUS_T vchiq_add_service(
 	VCHIQ_INSTANCE_T              instance,
 	const VCHIQ_SERVICE_PARAMS_T *params,
@@ -259,12 +230,6 @@ VCHIQ_STATUS_T vchiq_add_service(
 }
 EXPORT_SYMBOL(vchiq_add_service);
 
-/****************************************************************************
-*
-*   vchiq_open_service
-*
-***************************************************************************/
-
 VCHIQ_STATUS_T vchiq_open_service(
 	VCHIQ_INSTANCE_T              instance,
 	const VCHIQ_SERVICE_PARAMS_T *params,
-- 
2.11.0
