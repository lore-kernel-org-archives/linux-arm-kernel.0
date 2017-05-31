From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Wed, 31 May 2017 15:27:41 +0530
Subject: [PATCH v2 0/2] Add ThunderX2 SoC Performance Monitoring Unit driver
Message-ID: <1496224663-13819-1-git-send-email-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
The SoC has PMU support in its L3 cache controller (L3C) and in the
DDR4 Memory Controller (DMC).

v2:
     - rebased to 4.12-rc1
     - Removed Arch VULCAN dependency
     - update SMC call parameters as per latest firmware.

v1: Initial patch

Ganapatrao Kulkarni (2):
  perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
  perf: ThunderX2: Add Cavium Thunderx2 SoC UNCORE PMU driver

 Documentation/perf/thunderx2-pmu.txt |  60 +++
 drivers/perf/Kconfig                 |   9 +
 drivers/perf/Makefile                |   1 +
 drivers/perf/thunderx2_pmu.c         | 968 +++++++++++++++++++++++++++++++++++
 4 files changed, 1038 insertions(+)
 create mode 100644 Documentation/perf/thunderx2-pmu.txt
 create mode 100644 drivers/perf/thunderx2_pmu.c

-- 
1.8.1.4
