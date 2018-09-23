From: qader.aymen@gmail.com (Aymen Qader)
Date: Sun, 23 Sep 2018 14:07:29 +0100
Subject: [PATCH 3/5] staging: vc04_services: Add spaces after commas
In-Reply-To: <20180923130733.4128-1-qader.aymen@gmail.com>
References: <20180923130733.4128-1-qader.aymen@gmail.com>
Message-ID: <20180923130733.4128-3-qader.aymen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the checkpatch.pl error:

ERROR: space required after that ','

in the interface/vchi directory

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index cb2582a4eb6a..d8e660240a44 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -92,14 +92,14 @@ typedef struct vchi_msg_vector_ex {
 } VCHI_MSG_VECTOR_EX_T;
 
 // Construct an entry in a msg vector for a pointer (p) of length (l)
-#define VCHI_VEC_POINTER(p,l)  VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } }
+#define VCHI_VEC_POINTER(p, l)  VCHI_VEC_POINTER, { { (VCHI_MEM_HANDLE_T)(p), (l) } }
 
 // Construct an entry in a msg vector for a message handle (h), starting at offset (o) of length (l)
-#define VCHI_VEC_HANDLE(h,o,l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
+#define VCHI_VEC_HANDLE(h, o, l) VCHI_VEC_HANDLE,  { { (h), (o), (l) } }
 
 // Macros to manipulate 'FOURCC' values
 #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
-#define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF,(x >> 16) & 0xFF,(x >> 8) & 0xFF, x & 0xFF
+#define FOURCC_TO_CHAR(x) (x >> 24) & 0xFF, (x >> 16) & 0xFF, (x >> 8) & 0xFF, x & 0xFF
 
 // Opaque service information
 struct opaque_vchi_service_t;
-- 
2.17.1
