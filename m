From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 13 Mar 2018 11:24:29 -0600
Subject: [PATCH 0/2] coresight: next v4.16-rc5
Message-ID: <1520961871-11196-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

These two patches came in last week and are confined to Coresight.  Given
the late(ish) time in the cycle I would have normally waited for the
next one but the changes are small and trivial.

Please consider - if you think it's too late they'll simply go in later.

Thanks,
Mathieu 

Bo Yan (1):
  coresight: etm4x: Fix bit shifting

Leo Yan (1):
  coresight: Use %px to print pcsr instead of %p

 drivers/hwtracing/coresight/coresight-cpu-debug.c   | 2 +-
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.4
