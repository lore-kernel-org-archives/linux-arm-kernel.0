From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon, 24 Apr 2017 16:16:23 +0200
Subject: [PATCH 3/9] crypto: ixp4xx - Use IPAD/OPAD constant
In-Reply-To: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
References: <20170424141629.27155-1-clabbe.montjoie@gmail.com>
Message-ID: <20170424141629.27155-3-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch simply replace all occurrence of HMAC IPAD/OPAD value by their
define.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/ixp4xx_crypto.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/ixp4xx_crypto.c b/drivers/crypto/ixp4xx_crypto.c
index 771dd26..3b7680c 100644
--- a/drivers/crypto/ixp4xx_crypto.c
+++ b/drivers/crypto/ixp4xx_crypto.c
@@ -90,8 +90,6 @@
 #define CTL_FLAG_PERFORM_AEAD	0x0008
 #define CTL_FLAG_MASK		0x000f
 
-#define HMAC_IPAD_VALUE   0x36
-#define HMAC_OPAD_VALUE   0x5C
 #define HMAC_PAD_BLOCKLEN SHA1_BLOCK_SIZE
 
 #define MD5_DIGEST_SIZE   16
-- 
2.10.2
