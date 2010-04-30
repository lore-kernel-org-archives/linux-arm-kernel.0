From: jason.mcmullan@gmail.com (Jason S. McMullan)
Date: Fri, 30 Apr 2010 14:54:10 -0400
Subject: [PATCH] Extend cache-l2x0 to support the 16-way PL310
Message-ID: <1272653651-11590-1-git-send-email-jason.mcmullan@netronome.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support the PL310 16-way cache controller.

Also adds support for smaller than 8 way PL210 controllers.

Signed-off-by: Jason S. McMullan <jason.mcmullan@netronome.com>

Jason S. McMullan (1):
  [arm l2x0] Extend cache-l2x0 to support the 16-way PL310

 arch/arm/include/asm/hardware/cache-l2x0.h |    3 ++
 arch/arm/mm/cache-l2x0.c                   |   30 ++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 4 deletions(-)
