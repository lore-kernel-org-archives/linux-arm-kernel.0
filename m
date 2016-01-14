From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 14 Jan 2016 11:57:55 -0700
Subject: [PATCH 0/5] coresight: miscellaneous fix and cleanup 
Message-ID: <1452797880-4365-1-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches present a few fix and some cleanup code for the coresight
subsystem. The set serves as a foundation for the upcoming 8th iteration
of the "coresight: integration with perf" patch set but not part of the
new functionality, hence choosing to send separately.

This set is based on [1].

Thanks,
Mathieu

Mathieu Poirier (5):
  coresight: fixing indentation problem
  coresight: fixing lockdep error
  coresight: coresight_unregister() function cleanup
  coresight: release reference taken by 'bus_find_device()'
  coresight: remove csdev's link from topology

 drivers/hwtracing/coresight/coresight.c | 57 +++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 6 deletions(-)

-- 
2.1.4
