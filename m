From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 24 May 2010 04:30:04 +0100
Subject: [PATCH 3/8] ARM: S3C24XX: Documentation: update documentation overview
In-Reply-To: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
References: <1274671809-9821-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1274671809-9821-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the two new SoCs added in this release cycle and update the notes
on the gpiolib conversion.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 Documentation/arm/Samsung-S3C24XX/Overview.txt |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/Documentation/arm/Samsung-S3C24XX/Overview.txt b/Documentation/arm/Samsung-S3C24XX/Overview.txt
index 081892d..0f11fcc 100644
--- a/Documentation/arm/Samsung-S3C24XX/Overview.txt
+++ b/Documentation/arm/Samsung-S3C24XX/Overview.txt
@@ -8,10 +8,16 @@ Introduction
 
   The Samsung S3C24XX range of ARM9 System-on-Chip CPUs are supported
   by the 's3c2410' architecture of ARM Linux. Currently the S3C2410,
-  S3C2412, S3C2413, S3C2440, S3C2442 and S3C2443 devices are supported.
+  S3C2412, S3C2413, S3C2416 S3C2440, S3C2442, S3C2443 and S3C2450 devices
+  are supported.
 
   Support for the S3C2400 and S3C24A0 series are in progress.
 
+  The S3C2416 and S3C2450 devices are very similar and S3C2450 support is
+  included under the arch/arm/mach-s3c2416 directory. Note, whilst core
+  support for these SoCs is in, work on some of the extra peripherals
+  and extra interrupts is still ongoing.
+
 
 Configuration
 -------------
@@ -209,6 +215,9 @@ GPIO
   Newer kernels carry GPIOLIB, and support is being moved towards
   this with some of the older support in line to be removed.
 
+  As of v2.6.34, the move towards using gpiolib support is almost
+  complete, and very little of the old calls are left.
+
 
 Clock Management
 ----------------
-- 
1.6.3.3
