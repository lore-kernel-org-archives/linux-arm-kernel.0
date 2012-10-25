From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 25 Oct 2012 15:53:04 +0530
Subject: [PATCH 0/2] i2c: omap: cleanups
Message-ID: <1351160586-12306-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Applies on Felipe's series
http://www.spinics.net/lists/linux-omap/msg79995.html

Tested with Terro sys fix + Felipe's stop sched_clock() during suspend
on omap3630 beagle both idle and suspend.

Functional testing on omap4sdp.


Shubhrajyoti D (2):
  i2c: omap: re-factor omap_i2c_init function
  i2c: omap: make reset a seperate function

 drivers/i2c/busses/i2c-omap.c |   97 +++++++++++++++++++++--------------------
 1 files changed, 49 insertions(+), 48 deletions(-)

-- 
1.7.5.4
