From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 15 Jul 2010 11:10:31 +0200
Subject: [PATCH v2] Samsung S5P SoC camera interface driver
Message-ID: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is a second version of my patch series adding support for
camera interface, video output and video processing contained 
in Samsung's S3C/S5P SoCs.

The first version can be found at:
 http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg01698.html

Changes since v1:
- support for multiple SoC variants through the platform device name overriding
  (S5PC100 and SPV210 version definitions included)


Kernel tree
-----------------

This patch series has been prepared in assumption that the following
patches for s3c-fb driver have been applied:

http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg02000.html 
[PATCH v4 0/19] Various s3c-fb updates


Patches
-----------------

The following patch series contains:

[PATCH 01/10 v2] ARM: Samsung: Add FIMC register and platform definitions
[PATCH 02/10 v2] ARM: Samsung: Add FIMC resource definition and FIMC driver platform helpers
[PATCH 03/10 v2] ARM: Samsung: Add platform definitions for local FIMC/FIMD fifo path
[PATCH 04/10 v2] v4l: Add Samsung FIMC (video postprocessor) driver
[PATCH 05/10 v2] s3c-fb: Add v4l2 subdevice to support framebuffer local fifo input path
[PATCH 06/10 v2] ARM: S5PV210: Add fifo link definitions for FIMC and framebuffer
[PATCH 07/10 v2] ARM: S5PV210: add common Aquila & GONI code
[PATCH 08/10 v2] ARM: S5PV210: enable FIMC on Aquila
[PATCH 09/10 v2] ARM: s5pv210: enable FIMC on Goni
[PATCH 10/10 v2] ARM: S5PC100: enable FIMC on SMDKC100


Best regards,
-- 
Sylwester Nawrocki
Samsung Poland R&D Center
