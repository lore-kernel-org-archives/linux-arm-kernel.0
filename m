From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 19 Apr 2018 11:39:43 -0600
Subject: [PATCH 0/3] coresight tmc etr: Miscellanous fixes
Message-ID: <1524159586-4841-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set is addressing a couple of issues with TMC-ETR function
tmc_enable_etr_sink_sysfs() as pointed out by Dan Carpenter [1]
along with an extra newline left behind inadvertently.

[1]. https://www.spinics.net/lists/arm-kernel/msg647061.html

Mathieu Poirier (3):
  coresight tmc etr: Make memory check consistent in the same function
  coresight tmc etr: Fix uninitialised variable
  coresight tmc etr: Removing extra newline

 drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.7.4
