From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 15 Jan 2011 19:25:58 +0100
Subject: [PATCH 8/8] ARM: pxa: Update copyright notices for Palm devices
In-Reply-To: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
References: <1295115958-4811-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1295115958-4811-8-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/palm27x.c     |    3 +--
 drivers/pcmcia/pxa2xx_palmld.c  |    2 +-
 drivers/pcmcia/pxa2xx_palmtc.c  |    2 +-
 drivers/pcmcia/pxa2xx_palmtx.c  |    2 +-
 drivers/pcmcia/pxa2xx_vpac270.c |    3 +--
 5 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 405b92a..7d1434a 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -1,8 +1,7 @@
 /*
  * Common code for Palm LD, T5, TX, Z72
  *
- * Copyright (C) 2010
- * Marek Vasut <marek.vasut@gmail.com>
+ * Copyright (C) 2010-2011 Marek Vasut <marek.vasut@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/pcmcia/pxa2xx_palmld.c b/drivers/pcmcia/pxa2xx_palmld.c
index 59f8405..69f7367 100644
--- a/drivers/pcmcia/pxa2xx_palmld.c
+++ b/drivers/pcmcia/pxa2xx_palmld.c
@@ -4,7 +4,7 @@
  * Driver for Palm LifeDrive PCMCIA
  *
  * Copyright (C) 2006 Alex Osborne <ato@meshy.org>
- * Copyright (C) 2007-2008 Marek Vasut <marek.vasut@gmail.com>
+ * Copyright (C) 2007-2011 Marek Vasut <marek.vasut@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/pcmcia/pxa2xx_palmtc.c b/drivers/pcmcia/pxa2xx_palmtc.c
index e655af9..d0ad6a7 100644
--- a/drivers/pcmcia/pxa2xx_palmtc.c
+++ b/drivers/pcmcia/pxa2xx_palmtc.c
@@ -4,7 +4,7 @@
  * Driver for Palm Tungsten|C PCMCIA
  *
  * Copyright (C) 2008 Alex Osborne <ato@meshy.org>
- * Copyright (C) 2009 Marek Vasut <marek.vasut@gmail.com>
+ * Copyright (C) 2009-2011 Marek Vasut <marek.vasut@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/pcmcia/pxa2xx_palmtx.c b/drivers/pcmcia/pxa2xx_palmtx.c
index 06f7f14..1a25804 100644
--- a/drivers/pcmcia/pxa2xx_palmtx.c
+++ b/drivers/pcmcia/pxa2xx_palmtx.c
@@ -3,7 +3,7 @@
  *
  * Driver for Palm T|X PCMCIA
  *
- * Copyright (C) 2007-2008 Marek Vasut <marek.vasut@gmail.com>
+ * Copyright (C) 2007-2011 Marek Vasut <marek.vasut@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/drivers/pcmcia/pxa2xx_vpac270.c b/drivers/pcmcia/pxa2xx_vpac270.c
index c13f411..435002d 100644
--- a/drivers/pcmcia/pxa2xx_vpac270.c
+++ b/drivers/pcmcia/pxa2xx_vpac270.c
@@ -3,8 +3,7 @@
  *
  * Driver for Voipac PXA270 PCMCIA and CF sockets
  *
- * Copyright (C) 2010
- * Marek Vasut <marek.vasut@gmail.com>
+ * Copyright (C) 2010-2011 Marek Vasut <marek.vasut@gmail.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.7.2.3
