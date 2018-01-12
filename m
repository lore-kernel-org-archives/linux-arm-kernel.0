From: hch@lst.de (Christoph Hellwig)
Date: Fri, 12 Jan 2018 09:42:00 +0100
Subject: [PATCH 02/34] hexagon: remove unused flush_write_buffers definition
In-Reply-To: <20180112084232.2857-1-hch@lst.de>
References: <20180112084232.2857-1-hch@lst.de>
Message-ID: <20180112084232.2857-3-hch@lst.de>
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
