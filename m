From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu,  9 Aug 2018 21:21:10 +0200
Subject: [PATCH v5 18/18] kasan: add SPDX-License-Identifier mark to source
 files
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
Message-ID: <7c7356215cab699aaf06b12ef695c41eb2a1857e.1533842385.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a "SPDX-License-Identifier: GPL-2.0" mark to all source
files under mm/kasan.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/common.c         | 1 +
 mm/kasan/kasan.c          | 1 +
 mm/kasan/kasan_init.c     | 1 +
 mm/kasan/kasan_report.c   | 1 +
 mm/kasan/khwasan.c        | 1 +
 mm/kasan/khwasan_report.c | 1 +
 mm/kasan/quarantine.c     | 1 +
 mm/kasan/report.c         | 1 +
 8 files changed, 8 insertions(+)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index e5648f4218eb..f2576d93e74c 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains common KASAN and KHWASAN code.
  *
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 44ec228de0a2..128a865c9e05 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains core KASAN code.
  *
diff --git a/mm/kasan/kasan_init.c b/mm/kasan/kasan_init.c
index f436246ccc79..2dfa730a9d43 100644
--- a/mm/kasan/kasan_init.c
+++ b/mm/kasan/kasan_init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains some kasan initialization code.
  *
diff --git a/mm/kasan/kasan_report.c b/mm/kasan/kasan_report.c
index fdf2d77e3125..48da73f4ef7c 100644
--- a/mm/kasan/kasan_report.c
+++ b/mm/kasan/kasan_report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains KASAN specific error reporting code.
  *
diff --git a/mm/kasan/khwasan.c b/mm/kasan/khwasan.c
index 6b1309278e39..934f80b2d22e 100644
--- a/mm/kasan/khwasan.c
+++ b/mm/kasan/khwasan.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains core KHWASAN code.
  *
diff --git a/mm/kasan/khwasan_report.c b/mm/kasan/khwasan_report.c
index 51238b404b08..4e193546d94e 100644
--- a/mm/kasan/khwasan_report.c
+++ b/mm/kasan/khwasan_report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains KHWASAN specific error reporting code.
  *
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 3a8ddf8baf7d..0e4dc1a22615 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * KASAN quarantine.
  *
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index e031c78f2e52..633b4b245798 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file contains common KASAN and KHWASAN error reporting code.
  *
-- 
2.18.0.597.ga71716f1ad-goog
