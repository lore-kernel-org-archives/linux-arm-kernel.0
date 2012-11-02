From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 2 Nov 2012 16:09:43 +0530
Subject: [PATCH 0/2] i2c: omap: revision register updates
Message-ID: <1351852785-16961-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Does the followiing
- Make the revision a 32- bit consisting of rev_lo amd rev_hi each
of 16 bits.

- Also use the revision register for the erratum i207.

Also more cleanup is possible will check on that subsequently.


Tested on OMAP4430sdp  ,4460 ,omap3630 and 3430.

todo: omap2 testing.

Shubhrajyoti D (2):
  i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207
  i2c: omap: Fix the revision register read

 drivers/i2c/busses/i2c-omap.c |   62 +++++++++++++++++++++++++++++++---------
 1 files changed, 48 insertions(+), 14 deletions(-)

-- 
1.7.5.4
