From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Aug 2016 10:50:40 +0100
Subject: [PATCH 0/3] arm-ccn: fixes
Message-ID: <1470909043-7663-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

These patches fix a few issues I spotted in the ARM CCN driver.

I'd previously sent the first patch on its own, but as it wasn't picked up I've
rolled it up with the new patches.

I'm hoping that you will queue these with any other CCN driver updates. ;)

Thanks,
Mark.

Mark Rutland (3):
  arm-ccn: fix PMU interrupt flags
  arm-ccn: fix hrtimer registration
  arm-ccn: make event groups reliable

 drivers/bus/arm-ccn.c | 67 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 23 deletions(-)

-- 
1.9.1
