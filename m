From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 May 2014 15:56:31 +0900
Subject: [PATCH v4 04/11] ARM: EXYNOS: Remove file path from comment section
In-Reply-To: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
References: <1399704998-13321-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399704998-13321-5-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many files under "arm/mach-exynos" are having file path in file
comment section which is invalid now.
So for better code maintainability let's remove them.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/headsmp.S             |    2 --
 arch/arm/mach-exynos/hotplug.c             |    3 +--
 arch/arm/mach-exynos/include/mach/memory.h |    3 +--
 arch/arm/mach-exynos/platsmp.c             |    3 +--
 4 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/headsmp.S b/arch/arm/mach-exynos/headsmp.S
index cdd9d91..698c57f 100644
--- a/arch/arm/mach-exynos/headsmp.S
+++ b/arch/arm/mach-exynos/headsmp.S
@@ -1,6 +1,4 @@
 /*
- *  linux/arch/arm/mach-exynos4/headsmp.S
- *
  *  Cloned from linux/arch/arm/mach-realview/headsmp.S
  *
  *  Copyright (c) 2003 ARM Limited
diff --git a/arch/arm/mach-exynos/hotplug.c b/arch/arm/mach-exynos/hotplug.c
index 5eead53..73b0b5c 100644
--- a/arch/arm/mach-exynos/hotplug.c
+++ b/arch/arm/mach-exynos/hotplug.c
@@ -1,5 +1,4 @@
-/* linux arch/arm/mach-exynos4/hotplug.c
- *
+/*
  *  Cloned from linux/arch/arm/mach-realview/hotplug.c
  *
  *  Copyright (C) 2002 ARM Ltd.
diff --git a/arch/arm/mach-exynos/include/mach/memory.h b/arch/arm/mach-exynos/include/mach/memory.h
index 2a4cdb7..e19df1f 100644
--- a/arch/arm/mach-exynos/include/mach/memory.h
+++ b/arch/arm/mach-exynos/include/mach/memory.h
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-exynos4/include/mach/memory.h
- *
+/*
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 3611241..1f63596 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -1,5 +1,4 @@
-/* linux/arch/arm/mach-exynos4/platsmp.c
- *
+/*
  * Copyright (c) 2010-2011 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com
  *
-- 
1.7.10.4
