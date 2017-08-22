From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 22 Aug 2017 10:08:08 +0200
Subject: [PATCH 01/11] crypto: gcm - add GCM IV size constant
In-Reply-To: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
References: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
Message-ID: <20170822080818.12486-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many GCM users use directly GCM IV size instead of using some constant.

This patch add all IV size constant used by GCM.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 include/crypto/gcm.h | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 include/crypto/gcm.h

diff --git a/include/crypto/gcm.h b/include/crypto/gcm.h
new file mode 100644
index 000000000000..c50e057ea17e
--- /dev/null
+++ b/include/crypto/gcm.h
@@ -0,0 +1,8 @@
+#ifndef _CRYPTO_GCM_H
+#define _CRYPTO_GCM_H
+
+#define GCM_AES_IV_SIZE 12
+#define GCM_RFC4106_IV_SIZE 8
+#define GCM_RFC4543_IV_SIZE 8
+
+#endif
-- 
2.13.0
