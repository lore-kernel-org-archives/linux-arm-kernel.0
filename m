From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Tue,  1 Apr 2014 17:02:51 +0300
Subject: [PATCHv3 0/5] net: rfkill: gpio: cleanup and a few new acpi ids
Message-ID: <1396360976-28657-1-git-send-email-heikki.krogerus@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I hope this one is OK with everyone.

Changes since v2:
- Instead of changing the driver to use only indexed gpios, just
  hard-coding the names.

Changes since v1:
- Removed the gpio entries from arch/arm/mach-tegra/board-paz00.c


Heikki Krogerus (5):
  ARM: tegra: remove obsolete gpio entries
  net: rfkill: gpio: remove unused and obsolete platform parameters
  net: rfkill: gpio: add ACPI ID for GPS module on Lenovo Miix2
  net: rfkill: gpio: add ACPI IDs for a Broadcom bluetooth chip
  net: rfkill: gpio: hard-code the gpio names

 arch/arm/mach-tegra/board-paz00.c |  4 +---
 include/linux/rfkill-gpio.h       | 10 ----------
 net/rfkill/rfkill-gpio.c          | 40 +++++++++------------------------------
 3 files changed, 10 insertions(+), 44 deletions(-)

-- 
1.9.1
