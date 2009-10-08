From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu,  8 Oct 2009 09:47:20 +0200
Subject: [PATCH 4/6] mx25: Add missing copyright / license header
In-Reply-To: <1254988042-16737-4-git-send-email-s.hauer@pengutronix.de>
References: <1254988042-16737-1-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-2-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-3-git-send-email-s.hauer@pengutronix.de>
	<1254988042-16737-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1254988042-16737-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx25/devices.c |   18 ++++++++++++++++++
 arch/arm/mach-mx25/mx25pdk.c |   18 ++++++++++++++++++
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
index 25c3296..63511de 100644
--- a/arch/arm/mach-mx25/devices.c
+++ b/arch/arm/mach-mx25/devices.c
@@ -1,3 +1,21 @@
+/*
+ * Copyright 2009 Sascha Hauer, <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor,
+ * Boston, MA  02110-1301, USA.
+ */
+
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-mx25/mx25pdk.c b/arch/arm/mach-mx25/mx25pdk.c
index e99d7bb..d23ae57 100644
--- a/arch/arm/mach-mx25/mx25pdk.c
+++ b/arch/arm/mach-mx25/mx25pdk.c
@@ -1,3 +1,21 @@
+/*
+ * Copyright 2009 Sascha Hauer, <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor,
+ * Boston, MA  02110-1301, USA.
+ */
+
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/clk.h>
-- 
1.6.4.3
