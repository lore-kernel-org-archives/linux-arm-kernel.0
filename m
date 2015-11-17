From: shannon.zhao@linaro.org (shannon.zhao at linaro.org)
Date: Tue, 17 Nov 2015 17:57:02 +0800
Subject: [PATCH 04/13] xen: memory : Add new XENMAPSPACE type
 XENMAPSPACE_dev_mmio
In-Reply-To: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
Message-ID: <1447754231-7772-5-git-send-email-shannon.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 include/xen/interface/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/xen/interface/memory.h b/include/xen/interface/memory.h
index 2ecfe4f..9aa8988 100644
--- a/include/xen/interface/memory.h
+++ b/include/xen/interface/memory.h
@@ -160,6 +160,7 @@ DEFINE_GUEST_HANDLE_STRUCT(xen_machphys_mapping_t);
 #define XENMAPSPACE_gmfn_foreign 4 /* GMFN from another dom,
 				    * XENMEM_add_to_physmap_range only.
 				    */
+#define XENMAPSPACE_dev_mmio     5 /* device mmio region */
 
 /*
  * Sets the GPFN at which a particular page appears in the specified guest's
-- 
2.1.0
