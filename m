From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 10 Apr 2015 09:25:35 -0600
Subject: [PATCH 0/2] coresight: next 4.0-rc7 
Message-ID: <1428679537-26590-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good morning,

I'd appreciate if this could go in the 4.1 merge window with the other
coresight fix.  If this is too close for comfort then we'll simply get
the next one.

Thanks,
Mathieu

Mark Brown (2):
  coresight: etb10: Print size of buffer we fail to allocate
  coresight: etb10: Fix check for bogus buffer depth

 drivers/hwtracing/coresight/coresight-etb10.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
1.9.1
