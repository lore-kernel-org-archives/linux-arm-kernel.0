From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Mon, 12 Oct 2015 18:53:00 +0300
Subject: [PATCH v7 4/4] Documentation/features/KASAN: arm64 supports KASAN now
In-Reply-To: <1444665180-301-1-git-send-email-ryabinin.a.a@gmail.com>
References: <1444665180-301-1-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <1444665180-301-5-git-send-email-ryabinin.a.a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 Documentation/features/debug/KASAN/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index 14531da..703f578 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |       avr32: | TODO |
     |    blackfin: | TODO |
     |         c6x: | TODO |
-- 
2.4.9
