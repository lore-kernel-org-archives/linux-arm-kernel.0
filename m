From: eric.long@linaro.org (Eric Long)
Date: Wed, 20 Jan 2016 14:39:11 +0800
Subject: [RESEND PATCH 0/2] Remove the mistakes detected by the check tools.
Message-ID: <cover.1453271738.git.eric.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both of the two patches optimize the code and remove the mistakes and
warnings detected by the check tools.

Eric Long (2):
  coresight: tmc/etm4x: Remove the mistakes detected by sparse tool
  coresight: Remove the mistakes detected by smatch tool

 drivers/hwtracing/coresight/coresight-etm4x.c |    2 +-
 drivers/hwtracing/coresight/coresight-tmc.c   |    6 +++---
 drivers/hwtracing/coresight/of_coresight.c    |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.9.5
