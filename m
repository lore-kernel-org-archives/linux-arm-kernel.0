From: jason.mcmullan@netronome.com (Jason S. McMullan)
Date: Tue,  4 May 2010 11:00:53 -0400
Subject: [PATCH] [arm l2x0] Extend cache-l2x0 to support the 16-way PL310 (v3)
Message-ID: <1272985254-5675-1-git-send-email-jason.mcmullan@netronome.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the ARM PL310 16-way cache controller.

Add support for ARM PL210 cache controllers that are
not 8-way.

NEW: 

Log the discovered cache controller model, its number of
ways, CACHE_ID register, and AUX_CTRL register.

This version of the patch includes the changes requested
by Will Deacon.

Jason S. McMullan (1):
  [arm l2x0] Extend cache-l2x0 to support the 16-way PL310

 arch/arm/include/asm/hardware/cache-l2x0.h |    3 ++
 arch/arm/mm/cache-l2x0.c                   |   39 ++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)
