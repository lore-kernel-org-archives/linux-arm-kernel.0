From: ajaykumar.rs@samsung.com (Ajay Kumar)
Date: Tue, 20 Sep 2011 11:30:38 -0400
Subject: [PATCH 0/3] FB: Add window positioning support
Message-ID: <1316532641-2657-1-git-send-email-ajaykumar.rs@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for positioning the overlay windows on the LCD.

These patches are based on the discussion about adding features to fbdev at:
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg06292.html

To Florian:
  	include: fb: Add definiton for window positioning structure
  	video: s3c-fb: Modify s3c-fb driver to support window positioning

To Kukjin,
  	ARM: SAMSUNG: Embed window positioning data structure in s3c-fb plat
  		      data

 arch/arm/plat-samsung/include/plat/fb.h |    3 ++
 drivers/video/s3c-fb.c                  |   37 ++++++++++++++++++++++++++----
 include/linux/fb.h                      |    7 ++++++
 3 files changed, 42 insertions(+), 5 deletions(-)
