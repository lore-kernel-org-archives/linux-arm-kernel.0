From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 17 Dec 2015 08:47:01 -0700
Subject: [PATCH 0/2] coresight: next v4.4-rc5 
Message-ID: <1450367223-21068-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good day Greg,

Please queue the following patches for the 4.5 cycle.

Regards,
Mathieu

Andrew F. Davis (1):
  coresight: Fix a typo in Kconfig

Mathieu Poirier (1):
  coresight: checking for NULL string in coresight_name_match()

 drivers/hwtracing/coresight/Kconfig     | 2 +-
 drivers/hwtracing/coresight/coresight.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.1.4
