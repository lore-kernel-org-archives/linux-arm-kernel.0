From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 15 Jan 2010 10:39:34 +0000
Subject: [PATCH] ARM: SAMSUNG: Add initial documentation directory and overview
In-Reply-To: <1263551977-15090-1-git-send-email-ben-linux@fluff.org>
References: <1263551977-15090-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263551977-15090-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Start Documentation/arm/Samsung and add an initial overview file
which whilst is not complete, is better than nothing.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 Documentation/arm/Samsung/Overview.txt |   63 ++++++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/Samsung/Overview.txt

diff --git a/Documentation/arm/Samsung/Overview.txt b/Documentation/arm/Samsung/Overview.txt
new file mode 100644
index 0000000..c3d2f44
--- /dev/null
+++ b/Documentation/arm/Samsung/Overview.txt
@@ -0,0 +1,63 @@
+		Samsung ARM Linux Overview
+		==========================
+
+Introduction
+------------
+
+  The Samsung range of ARM SoCs spans many similar devices, from the initial
+  ARM9 through to the newest ARM cores. This document shows an overview of
+  the current kernel support, how to use it and where to find the code
+  that supports this.
+
+  The currently supported SoCs are:
+
+  - S3C24XX: See Documentation/arm/Samsung-S3C24XX/Overview.txt for full list
+  - S3C64XX: S3C6400 and S3C6410
+
+  S5PC100 and S5PC110 support is currently being merged
+
+
+S3C24XX Systems
+---------------
+
+  There is still documentation in Docuemntation/arm/Samsung-S3C24XX/ which
+  deals with the architecture and drivers specific to these devices.
+
+  See Documentation/arm/Samsung-S3C24XX/Overview.txt for more information
+  on the implementation details and specific support.
+
+
+Configuration
+-------------
+
+  A number of configurations are supplied, as there is no current way of
+  unifying all the SoCs into one kernel.
+
+  [ to finish ]
+
+Layout
+------
+
+  [ to finish ]
+
+
+Port Contributors
+-----------------
+
+  Ben Dooks (BJD)
+  Vincent Sanders
+  Herbert Potzl
+  Arnaud Patard (RTP)
+  Roc Wu
+  Klaus Fetscher
+  Dimitry Andric
+  Shannon Holland
+  Guillaume Gourat (NexVision)
+  Christer Weinigel (wingel) (Acer N30)
+  Lucas Correia Villa Real (S3C2400 port)
+
+
+Document Author
+---------------
+
+Copyright 2009 Ben Dooks <ben-linux@fluff.org>
-- 
1.6.0.4
