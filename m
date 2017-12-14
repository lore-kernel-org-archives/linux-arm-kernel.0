From: lameli67@gmail.com (Mikhail Shvetsov)
Date: Thu, 14 Dec 2017 23:40:03 +0300
Subject: [PATCH 1/3] staging: vchiq_arm: Remove useless comments
In-Reply-To: <cover.1513283180.git.lameli67@gmail.com>
References: <cover.1513283180.git.lameli67@gmail.com>
Message-ID: <8ca203ae9222beeff6b6f2eda829e0cea702cd4e.1513283180.git.lameli67@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mikhail Shvetsov <lameli67@gmail.com>
---
 .../interface/vchiq_arm/vchiq_kern_lib.c           | 35 +---------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
index 34f746db19cd..4a40b9b31a5a 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c
@@ -31,7 +31,6 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-/* ---- Include Files ---------------------------------------------------- */
 
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -41,9 +40,6 @@
 #include "vchiq_arm.h"
 #include "vchiq_killable.h"
 
-/* ---- Public Variables ------------------------------------------------- */
-
-/* ---- Private Constants and Types -------------------------------------- */
 
 struct bulk_waiter_node {
 	struct bulk_waiter bulk_waiter;
@@ -64,11 +60,7 @@ static VCHIQ_STATUS_T
 vchiq_blocking_bulk_transfer(VCHIQ_SERVICE_HANDLE_T handle, void *data,
 	unsigned int size, VCHIQ_BULK_DIR_T dir);
 
-/****************************************************************************
-*
-*   vchiq_initialise
-*
-***************************************************************************/
+
 #define VCHIQ_INIT_RETRIES 10
 VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 {
@@ -120,11 +112,6 @@ VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
 }
 EXPORT_SYMBOL(vchiq_initialise);
 
-/****************************************************************************
-*
-*   vchiq_shutdown
-*
-***************************************************************************/
 
 VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
 {
@@ -168,22 +155,12 @@ VCHIQ_STATUS_T vchiq_shutdown(VCHIQ_INSTANCE_T instance)
 }
 EXPORT_SYMBOL(vchiq_shutdown);
 
-/****************************************************************************
-*
-*   vchiq_is_connected
-*
-***************************************************************************/
 
 static int vchiq_is_connected(VCHIQ_INSTANCE_T instance)
 {
 	return instance->connected;
 }
 
-/****************************************************************************
-*
-*   vchiq_connect
-*
-***************************************************************************/
 
 VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
 {
@@ -214,11 +191,6 @@ VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
 }
 EXPORT_SYMBOL(vchiq_connect);
 
-/****************************************************************************
-*
-*   vchiq_add_service
-*
-***************************************************************************/
 
 VCHIQ_STATUS_T vchiq_add_service(
 	VCHIQ_INSTANCE_T              instance,
@@ -259,11 +231,6 @@ VCHIQ_STATUS_T vchiq_add_service(
 }
 EXPORT_SYMBOL(vchiq_add_service);
 
-/****************************************************************************
-*
-*   vchiq_open_service
-*
-***************************************************************************/
 
 VCHIQ_STATUS_T vchiq_open_service(
 	VCHIQ_INSTANCE_T              instance,
-- 
2.11.0
