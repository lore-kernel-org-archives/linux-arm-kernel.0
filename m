From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 08:59:56 +0100
Subject: [PATCH 02/33] hexagon: remove unused flush_write_buffers definition
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
Message-ID: <20180110080027.13879-3-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/include/asm/io.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index 66f5e9a61efc..9e8621d94ee9 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -330,8 +330,6 @@ static inline void outsl(unsigned long port, const void *buffer, int count)
 	}
 }
 
-#define flush_write_buffers() do { } while (0)
-
 #endif /* __KERNEL__ */
 
 #endif
-- 
2.14.2
