From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Thu, 25 Oct 2012 20:09:47 +0530
Subject: [PATCHv4 0/2] i2c: omap: cleanups
Message-ID: <1351175989-6401-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Applies on Felipe's series
http://www.spinics.net/lists/linux-omap/msg79995.html

Tested with Terro sys fix + Felipe's stop sched_clock() during suspend
on omap3630 beagle both idle and suspend.

Functional testing on omap4sdp.

Todo: all the error cases may not need a reset. 

Shubhrajyoti D (2):
  i2c: omap: re-factor omap_i2c_init function
  i2c: omap: make reset a seperate function

 drivers/i2c/busses/i2c-omap.c |   97 +++++++++++++++++++++--------------------
 1 files changed, 50 insertions(+), 47 deletions(-)

-- 
1.7.5.4
