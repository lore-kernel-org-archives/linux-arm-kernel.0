From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri,  6 Jul 2018 14:25:42 -0700
Subject: [GIT PULL 3/3] SOC: Driver updates for v4.19
In-Reply-To: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1530912342-4641-1-git-send-email-santosh.shilimkar@oracle.com>
Message-ID: <1530912342-4641-3-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/soc_drivers_for_4.19

for you to fetch changes up to 990c10091db318c7eb7e8935c86b6f7c01585015:

  soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused (2018-07-06 09:47:51 -0700)

----------------------------------------------------------------
Keystone SOC driver update for 4.19

 -  Add suspend/resume functionality to TI EMIF SRAM driver
 -  Add wakeup M3 RTC self refresh support
 -  Fix for the PM runtime ifdefs

----------------------------------------------------------------
Arnd Bergmann (1):
      soc: ti: wkup_m3_ipc: mark PM functions as __maybe_unused

Dave Gerlach (2):
      memory: ti-emif-sram: Add resume function to recopy sram code
      soc: ti: wkup_m3_ipc: Add wkup_m3_request_wake_src

Keerthy (1):
      soc: ti: wkup_m3_ipc: Add rtc_only with ddr in self refresh mode support

 drivers/memory/ti-emif-pm.c  | 33 +++++++++++++++++++
 drivers/soc/ti/wkup_m3_ipc.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/wkup_m3_ipc.h  |  9 ++++++
 3 files changed, 118 insertions(+)
