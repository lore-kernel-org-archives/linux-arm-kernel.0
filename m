From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 6 Mar 2011 00:18:48 +0800
Subject: A few mxsfb patches
Message-ID: <1299341931-30241-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches came from the work of adding framebuffer for mx28evk and
mx23evk boards.  They are all minor changes.

 [PATCH 1/3] video: mxsfb: smarten the code a little bit
 [PATCH 2/3] video: mxsfb: fix the incorrect error checking for alloc_pages_exact
 [PATCH 3/3] video: mxsfb: add DOTCLK polarity configuration support

 arch/arm/mach-mxs/include/mach/mxsfb.h |    3 ++-
 drivers/video/mxsfb.c                  |   25 ++++++++++++++-----------
 2 files changed, 16 insertions(+), 12 deletions(-)

Regards,
Shawn
