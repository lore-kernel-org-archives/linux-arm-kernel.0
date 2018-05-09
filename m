From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  9 May 2018 18:07:06 +0100
Subject: [PATCH 0/8] firmware: arm_scmi: trivial cleanups
Message-ID: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This contains all of the trivial review comments that were not addressed
as the series was queued for v4.17 and were not critical.

Regards,
Sudeep

Sudeep Holla (8):
  firmware: arm_scmi: improve code readability using bitfield accessor
    macros
  firmware: arm_scmi: fix kernel-docs documentation
  firmware: arm_scmi: rename get_transition_latency and
    add_opps_to_device
  firmware: arm_scmi: rename scmi_xfer_{init,get,put}
  firmware: arm_scmi: drop unused `con_priv` structure member
  firmware: arm_scmi: remove unnecessary bitmap_zero
  firmware: arm_scmi: improve exit paths and code readability
  firmware: arm_scmi: simplify exit path by returning on error

 drivers/cpufreq/scmi-cpufreq.c      |   4 +-
 drivers/firmware/arm_scmi/base.c    |  43 +++++++-------
 drivers/firmware/arm_scmi/bus.c     |  22 ++++----
 drivers/firmware/arm_scmi/clock.c   |  24 ++++----
 drivers/firmware/arm_scmi/common.h  |  22 ++++----
 drivers/firmware/arm_scmi/driver.c  | 109 ++++++++++++++++++------------------
 drivers/firmware/arm_scmi/perf.c    |  38 ++++++-------
 drivers/firmware/arm_scmi/power.c   |  16 +++---
 drivers/firmware/arm_scmi/sensors.c |  20 +++----
 include/linux/scmi_protocol.h       |  18 ++++--
 10 files changed, 166 insertions(+), 150 deletions(-)

--
2.7.4
