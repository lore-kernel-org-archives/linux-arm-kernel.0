From: andreyknvl@google.com (Andrey Konovalov)
Date: Fri, 12 Jan 2018 17:49:27 +0100
Subject: [PATCH v2 1/2] kasan: fix prototype author email address
In-Reply-To: <cover.1515775666.git.andreyknvl@google.com>
References: <cover.1515775666.git.andreyknvl@google.com>
Message-ID: <de3b7ffc30a55178913a7d3865216aa7accf6c40.1515775666.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new one.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.c  | 2 +-
 mm/kasan/report.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index 405bba487df5..cb4065f31f7f 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -5,7 +5,7 @@
  * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
  *
  * Some code borrowed from https://github.com/xairy/kasan-prototype by
- *        Andrey Konovalov <adech.fo@gmail.com>
+ *        Andrey Konovalov <andreyknvl@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 410c8235e671..eee796a005ac 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -5,7 +5,7 @@
  * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
  *
  * Some code borrowed from https://github.com/xairy/kasan-prototype by
- *        Andrey Konovalov <adech.fo@gmail.com>
+ *        Andrey Konovalov <andreyknvl@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
2.16.0.rc1.238.g530d649a79-goog
